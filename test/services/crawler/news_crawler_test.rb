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
      updated_items = $news_indexing[0..2]
      items = $news[*updated_items]
      Crawler::NewsCrawler.instance.trigger_crawl items
      $news[$news_indexing[0]].assert_valid_keys(:img, :desc)
      $news[$news_indexing[1]].assert_valid_keys(:img, :desc)
      $news[$news_indexing[2]].assert_valid_keys(:img, :desc)
    end
  end
end

