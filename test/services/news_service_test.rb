require 'test_helper'

class NewsServiceTest < ActiveSupport::TestCase
  test "#read function should function return array data limit by page and offset by per_page " do
    items = NewsService.instance.read 1, 10
    assert_equal 10, items[:data].length
    assert_equal 1, items[:page]
    assert_equal 30, items[:total_objects]
    assert_equal 3, items[:total_pages]
  end

  test "#write function should write new_item to $news " do
    item = {
      id: '123456',
      title: 'Test Write function',
      author: 'something',
      site_link: 'https://google.com.vn',
      site_name: 'google.com',
      time: '2 days ago',
      points: '123 points',
      comments: '500 comments'
    }
    NewsService.instance.write item
    [:id, :title, :author, :site_name, :site_link, :time, :points, :comments].each do |v|
      assert_equal $news["123456"][v], item[v]
    end
    $news.delete(item[:id])
  end

  test "#find_by_id function return object {data: data}" do
    item = $news[$news_indexing[0]]
    data = NewsService.instance.find_by_id item[:id]
    [:id, :title, :author, :site_name, :site_link, :time, :points, :comments].each do |v|
      assert_equal data[:data][v], item[v]
    end
  end

  test "#write_by_id function should update $news by id " do
    item = $news[$news_indexing[0]]
    NewsService.instance.write_by_id item[:id], {test: 'a'}
    assert_equal $news[$news_indexing[0]][:test], 'a'
  end
end

