require 'singleton'

class NewsService
  include Singleton

  def read page = 0, per_page = 10
    page = page&.to_i.nil? ? 0 : page&.to_i
    per_page = per_page&.to_i.nil? ? 10 : per_page&.to_i
    result = $news_indexing.slice(page * per_page, per_page)
    data = result.nil? ? [] : $news.slice(*result).values
    {
      data: data,
      page: page,
      total_objects: $news_indexing.length,
      total_pages: ($news_indexing.length / per_page).round
    }
  end

  def find_by_id id
    {
      data: $news[id]
    }
  end

  def write new_data
    return if new_data[:id].nil?
    $news_indexing.unshift(new_data[:id]) if $news[new_data[:id]].nil?
    $news[new_data[:id]] = new_data
  end

  def write_by_id hash_id, new_data
    $news[hash_id] = $news[hash_id].merge(new_data)
  end
end
