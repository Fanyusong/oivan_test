class NewsCrawlerJob
  include SuckerPunch::Job

  def perform
    puts "-------- Started Crawling -------"
    Crawler::NewsCrawler.instance.crawl
    NewsCrawlerJob.perform_in(300)
    puts "-------- Ended Crawling -------"
  end
end
