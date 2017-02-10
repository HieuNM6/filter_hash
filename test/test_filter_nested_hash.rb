require 'minitest/autorun'
require './lib/filter_nested_hash'
require 'oj'
require_relative 'test_helper/test_helper'

class TestFilterNestedHash < Minitest::Test
    def setup
        @nested_hash = FilterNestedHash.new(json_sample)
    end

    def test_remove_page_info
        assert_equal @nested_hash.base_node, Oj.load(json_remove_page)
    end

    def test_remove_hash_contain_privacy
        assert_equal @nested_hash.hash_filter(@nested_hash.base_node, "rolea"), Oj.load(json_remove_privacy)
    end

    def test_remove_hash_contain_privacy_right
      assert_equal @nested_hash.hash_filter(Oj.load(json_privacy_with_roleb), "roleb"), Oj.load(json_privacy_with_roleb)
    end

    def test_remove_hash_contain_privacy_not_right
      assert_equal @nested_hash.hash_filter(Oj.load(json_privacy_with_roleb), "rolec"), Oj.load(json_remove_privacy)
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

    def json_privacy_with_roleb
        File.read('./fixtures/json_privacy_with_right_roleb.json')
    end
end