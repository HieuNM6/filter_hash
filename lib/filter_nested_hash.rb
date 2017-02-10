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
        if v.include?(role)
          return hash
        else
          return nil
        end
      elsif k == "children" && v.is_a?(Array) && !v.empty?
        tmp = []
        v.each do |e|
          unless hash_filter(e,role).nil?
            tmp.push(hash_filter(e, role))
          end
        end
        hash["children"] = tmp
      end
    end
    hash
  end
end