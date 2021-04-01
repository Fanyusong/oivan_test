$news = {}
$news_indexing = []
Crawler::NewsCrawler.instance.crawl
unless Rails.env.test?
  NewsCrawlerJob.perform_in(300)
end
