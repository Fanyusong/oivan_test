# Init Store for hold data of all news we crawled
#   with type object like this {id: {id: string, title: string, author: string, ...}}
$news = {}
# Init Store for hold array of id of all news
#   with type array like this [id1, id2, ....]
$news_indexing = []
# When init app we will start crawl data
Crawler::NewsCrawler.instance.crawl
# Send background job for auto crawl data after 5 minutes
unless Rails.env.test?
  NewsCrawlerJob.perform_in(300)
end
