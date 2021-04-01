require 'test_helper'

module Crawler
  class BaseCrawlerTest < ActiveSupport::TestCase
    test "Exec function return data when url ='https://news.ycombinator.com/best' " do
      raw_data = Crawler::BaseCrawler.new("https://news.ycombinator.com/best").exec
      assert_equal Readability::Document, raw_data.class
      assert_equal String, raw_data.content.class
    end

    test "#Exec function return nil when url = '' " do
      raw_data = Crawler::BaseCrawler.new("").exec
      assert_nil raw_data
    end
  end
end

