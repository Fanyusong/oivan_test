require "test_helper"

class Api::NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_news_index_url, xhr: true
    assert_response :success
  end

  test "should get index and return response data = {data: {data: [...], page: 0, total_pages: 30, total_objects: 30}}" do
    get api_news_index_url, xhr: true
    resp = JSON.parse(@response.body)
    assert_equal 0, resp["data"]["page"]
    assert_equal 10, resp["data"]["data"].length
    assert_equal 30, resp["data"]["total_objects"]
    assert_equal 3, resp["data"]["total_pages"]
  end

  test "should get show" do
    get "/api/news/#{$news_indexing[0]}", xhr: true
    assert_response :success
  end

  test "should get /api/news/${id} and return response data type like this {data: {id: string, title: string, site_name: string, site_link: string, author: string, time: string, comments: string, points: string, img: string, desc: string }}" do
    id = $news_indexing[0]
    data = $news[id]
    get "/api/news/#{id}", xhr: true
    resp = JSON.parse(@response.body)
    assert_equal id, resp["data"]["data"]["id"]
    [:title, :site_name, :site_link, :author, :time, :comments, :points, :img, :desc].each do |v|
      assert_equal  data[v], resp["data"]["data"][v.to_s]
    end
  end

  test "should get /api/news/${id} and return response data = {data: null}" do
    get "/api/news/something", xhr: true
    resp = JSON.parse(@response.body)
    assert_nil resp["data"]["data"]
  end
end
