require 'rest-client'
API_KEY = "cba4b9a885984bc49ddefc159d1fbb23"
LEFT_SOURCES = "cnn,the-new-york-times,cbs-news"
CENTER_SOURCES = "bbc-news,al-jazeera-english,the-wall-street-journal"
RIGHT_SOURCES = "fox-news,breitbart-news,national-review"

CATEGORIES = ["CLIMATE", "IMMIGRATION", "2020", "NATIONAL+DEBT", "ABORTION", "BORDER" ]

CATEGORIES.each do |topic|
  news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{LEFT_SOURCES}&pageSize=10&apiKey=#{API_KEY}"
  response = JSON.parse( RestClient.get("#{news_url}"))
  articles = response["articles"]

  articles.each do |article|
    Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "left", topic: topic )
  end

end

CATEGORIES.each do |topic|
  news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{CENTER_SOURCES}&pageSize=10&apiKey=#{API_KEY}"
  response = JSON.parse( RestClient.get("#{news_url}"))
  articles = response["articles"]

  articles.each do |article|
    Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "center", topic: topic )
  end

end

CATEGORIES.each do |topic|
  news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{RIGHT_SOURCES}&pageSize=10&apiKey=#{API_KEY}"
  response = JSON.parse( RestClient.get("#{news_url}"))
  articles = response["articles"]

  articles.each do |article|
    Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "right", topic: topic )
  end

end
