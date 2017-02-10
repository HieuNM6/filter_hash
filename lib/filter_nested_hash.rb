require 'oj'

class FilterNestedHash
  attr_reader :hash
  def initialize(input_json="")
      @hash = Oj.load(input_json)
  end

  def base_node
      @hash["page"]["nodes"]
  end

  def hash_filter(hash, role)
    hash.each do |k, v|
      if k == "privacy" && v.is_a?(Array) && !v.empty?
        if role.any? { |e| v.to_set.include?(e)}
          return hash
        else
          return nil
        end
      elsif k == "children" && v.is_a?(Array) && !v.empty?
        tmp = []
        v.each do |e|
          tmp_filter = hash_filter(e, role)
          unless tmp_filter.nil?
            tmp.push(tmp_filter)
          end
        end
        hash["children"] = tmp
      end
    end
    hash
  end
end