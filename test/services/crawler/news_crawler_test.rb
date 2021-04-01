require 'test_helper'

module Crawler
  class NewsCrawlerTest < ActiveSupport::TestCase
    test "Crawl function return $news has 30 items and $news_indexing has 30 items" do
      $news = {}
      $news_indexing = []
      Crawler::NewsCrawler.instance.crawl
      assert_equal 30, $news_indexing.length
      assert_equal 30, $news.values.length
      assert_equal 30, $news.keys.length
    end

    test "trigger_crawl function should update data" do
      items = $news.slice(3).values
      Crawler::NewsCrawler.instance.trigger_crawl items
      assert_equal true, $news[$news_indexing[0]].key?(:img)
      assert_equal true, $news[$news_indexing[0]].key?(:desc)
    end
  end
end

