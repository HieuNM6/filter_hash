require 'oj'

class FilterNestedHash
    attr_reader :hash
    def initialize(input_json="")
       @hash = Oj.load(input_json)
    end

    def nodes
        @hash["page"]["nodes"]
    end
end