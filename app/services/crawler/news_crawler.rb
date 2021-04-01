require 'singleton'
require 'parallel'

module Crawler
  class NewsCrawler
    include Singleton

    def initialize
      @crawler = Crawler::BaseCrawler.new ENV['HACKER_NEWS_URL'] || 'https://news.ycombinator.com/best'
    end

    def crawl
      raw_data = @crawler.exec
      return unless raw_data
      items = raw_data.html.xpath('//table[@class="itemlist"]//tr[not(@class="spacer")]')
      return if items.length > 3 && items.length % 2 != 0
      items = items.reverse[2..-1]
      new = {}
      trigger_data = []
      items.each_with_index do |item, index|
        next if index.odd?
        new[:id] = items[index + 1].attributes["id"].value
        new[:title] = items[index + 1].children.css('.storylink').text()
        new[:site_link] = items[index + 1].children.css('.storylink')[0]["href"]
        new[:site_name] = items[index + 1].children.css('.sitestr').text()
        new[:author] = item.children.css('.hnuser').text()
        new[:time] = item.children.css('.age').text()
        new[:points] = item.children.css('.score').text()
        new[:comments] = item.children.css('.subtext').children[-2].text()
        NewsService.instance.write new.dup
        trigger_data << new.dup
      end
      trigger_crawl trigger_data
    end

    def trigger_crawl items
      ActiveSupport::Dependencies.interlock.permit_concurrent_loads do
        Parallel.each(items, in_threads: 3) do |item|
          new_data = {
            desc: '',
            img: ''
          }
          begin
            item_raw_data = Crawler::BaseCrawler.new(item[:site_link]).exec(get_largest_image: true)
            new_data[:desc] = item_raw_data&.content
            new_data[:img] = item_raw_data&.images&.first
          rescue StandardError => e
            puts e
          end
          NewsService.instance.write_by_id item[:id], new_data
        end
      end
    end
  end
end


