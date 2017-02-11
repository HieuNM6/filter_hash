require 'minitest/autorun'
require './lib/filter_nested_hash'
require 'oj'
require_relative 'test_helper/test_helper'

class TestFilterNestedHash < Minitest::Test
    def setup
        @nested_hash = FilterNestedHash.new(json_remove_page)
    end

    def test_remove_page_info
        assert_equal @nested_hash.input_hash, Oj.load(json_remove_page)
    end

    def test_remove_hash_contain_privacy
      @nested_hash.role = ["rolea"]
      assert_equal @nested_hash.exec_filter, Oj.load(json_remove_privacy)
    end

    def test_remove_hash_contain_privacy_right
      @nested_hash.input_hash = Oj.load(json_privacy_with_roleb)
      @nested_hash.role = ["roleb"]
      assert_equal @nested_hash.exec_filter, Oj.load(json_privacy_with_roleb)
    end

    def test_remove_hash_contain_privacy_not_right
      @nested_hash.input_hash = Oj.load(json_privacy_with_roleb)
      @nested_hash.role = ["rolec"]
      assert_equal @nested_hash.exec_filter, Oj.load(json_remove_privacy)
    end

    def test_remove_hash_contain_privacy_big_file
      @nested_hash.input_hash = Oj.load(json_big_file)
      @nested_hash.role = ["roleb"]
      assert_equal @nested_hash.exec_filter, Oj.load(json_big_file)
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

    def json_big_file
        File.read('./fixtures/json_big_file.json')
    end
end