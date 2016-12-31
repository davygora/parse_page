require 'nokogiri'
require 'open-uri'

results, authors = [], []

(1..5).each do |i|
  doc = Nokogiri::HTML(open("https://news.ycombinator.com/news?p=#{i}").read)

  doc.css('.athing').each do |article|
    title = article.css('.title .storylink').text
    href = article.css('.storylink')
    links = href.map{|l| l['href']}

    results.push(
      title: title,
      link: links)
  end
  doc.css('.subtext .hnuser').each do |u|
    author = u.text
    authors.push(
      author: author)
  end
end
