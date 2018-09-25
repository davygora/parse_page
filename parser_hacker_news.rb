require 'nokogiri'
require 'open-uri'
require 'json'

results, titles_links, authors = [], [], []

(1..5).each do |i|
  doc = Nokogiri::HTML(open("https://news.ycombinator.com/news?p=#{i}").read)

  doc.css('.athing').each do |article|
    title = article.css('.title .storylink').text
    href = article.css('.storylink')
    links = href.map{|l| l['href']}

    titles_links.push(
      title: title,
      url: links)
  end

  doc.css('.subtext .hnuser').each do |name|
    authors.push(
      author: name.text)
  end
end

results = titles_links.map.with_index {|e,i| e.merge(authors[i])}
File.open("hacke_news.txt", "w") {|file| file.puts JSON.pretty_generate(results)}
