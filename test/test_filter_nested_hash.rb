require 'minitest/autorun'
require './lib/filter_nested_hash'
require 'oj'

class TestFilterNestedHash < Minitest::Test
    def setup
        @nested_hash = FilterNestedHash.new(json_sample)
    end

    def test_remove_page_info
        assert_equal @nested_hash.nodes, Oj.load(json_remove_page)
    end

    def test_remove_hash_contain_privacy
        assert_equal @nested_hash.filter_privacy, Oj.load(json_remove_privacy)
    end

    private

    def json_sample
        File.read('./fixtures/json_sample.json')
    end

    def json_remove_page
        File.read('./fixtures/json_remove_page.json')
    end

    def json_remove_privacy
        File.read('./fixtures/json_remove_privacy.json')
    end
end