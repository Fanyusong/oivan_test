require 'readability'
require 'open-uri'

module Crawler
  class BaseCrawler
    attr_accessor :url

    def initialize url
      @url = url
    end

    def exec options = {}
      begin
        source = URI.open(@url).read
      rescue StandardError => e
        puts e
        return nil
      end
      Readability::Document.new(source, options)
    end
  end
end