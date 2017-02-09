require 'minitest/autorun'
require './filter_nested_hash'
require 'oj'

class TestFilterNestedHash < Minitest::Test
    def setup
        @nested_hash = FilterNestedHash.new(json_sample)
    end

    def test_remove_page_info
        assert_equal @nested_hash.nodes, Oj.load(json_remove_page)
    end

    private

    def json_sample
        '{"page":{"name":"","url":"","type":"","nodes":{"tag":"div","class":["container"],"children":[{"tag":"div","class":["row"],"children":[{"tag":"form","action":"/api/v1/login","method":"post","children":[{"tag":"label","text":"username","children":[{"tag":"input","type":"text","value":"{{user.username}}"}]},{"tag":"label","text":"password","children":[{"tag":"input","type":"password","value":"{{user.password}}","conditions":[{"condition":"AND","rules":[{"field":"username","type":"string","input":"text","operator":"not","value":"empty"}]}]}]},{"tag":"label","text":"remember password","children":[{"tag":"checkbox","name":"remember_password","value":"{{user.remember}}"}]},{"tag":"div","class":["row"],"children":[{"tag":"button","text":"login","type":"submit"}]}],"privacy":["role a","role b"]}]}]},"ds":{"user":{"type":"query","ds_table":"user","ds_conditions":[{"condition":"AND","rules":[{"field":"id","type":"integer","operator":"gt","value":"100"}]},{"condition":"AND","rules":[{"field":"id","type":"integer","operator":"lt","value":"200"}]}]}}}}'
    end

    def json_remove_page
        '{"tag":"div","class":["container"],"children":[{"tag":"div","class":["row"],"children":[{"tag":"form","action":"/api/v1/login","method":"post","children":[{"tag":"label","text":"username","children":[{"tag":"input","type":"text","value":"{{user.username}}"}]},{"tag":"label","text":"password","children":[{"tag":"input","type":"password","value":"{{user.password}}","conditions":[{"condition":"AND","rules":[{"field":"username","type":"string","input":"text","operator":"not","value":"empty"}]}]}]},{"tag":"label","text":"remember password","children":[{"tag":"checkbox","name":"remember_password","value":"{{user.remember}}"}]},{"tag":"div","class":["row"],"children":[{"tag":"button","text":"login","type":"submit"}]}],"privacy":["role a","role b"]}]}]}'
    end
end