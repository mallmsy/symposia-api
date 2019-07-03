require 'rest-client'

class FetchController < ApplicationController

  API_KEY = "cba4b9a885984bc49ddefc159d1fbb23"
  LEFT_SOURCES = "cnn,the-new-york-times,cbs-news,the-huffington-post,msnbc"
  CENTER_SOURCES = "bbc-news,the-wall-street-journal,associated-press,bloomberg,reuters,usa-today"
  RIGHT_SOURCES = "fox-news,breitbart-news,national-review,the-american-conservative"
  date = Date.yesterday
  DATE = date.to_s

  CATEGORIES = ["CLIMATE", "IMMIGRATION", "2020", "NATIONAL+DEBT", "ABORTION", "BORDER" ]

  @@posts = []

  def fetch_articles
    CATEGORIES.each do |topic|
      news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{LEFT_SOURCES}&from=#{DATE}&pageSize=3&apiKey=#{API_KEY}"
      response = JSON.parse( RestClient.get("#{news_url}"))
      articles = response["articles"]

      articles.each do |article|
        @post = Post.find_by(title: article["title"])
        if !@post
          @new_post = Post.create!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "left", topic: topic )

          @@posts << @new_post
        end
      end
    end

    CATEGORIES.each do |topic|
      news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{CENTER_SOURCES}&from=#{DATE}&pageSize=3&apiKey=#{API_KEY}"
      response = JSON.parse( RestClient.get("#{news_url}"))
      articles = response["articles"]

      articles.each do |article|
        @post = Post.find_by(title: article["title"])
        if !@post
        @new_post = Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "center", topic: topic )

        @@posts << @new_post
        end
      end
    end

    CATEGORIES.each do |topic|
      news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{RIGHT_SOURCES}&from=#{DATE}&pageSize=3&apiKey=#{API_KEY}"
      response = JSON.parse( RestClient.get("#{news_url}"))
      articles = response["articles"]

      articles.each do |article|
        @post = Post.find_by(title: article["title"])
        if !@post
          @new_post = Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "right", topic: topic )

          @@posts << @new_post
        end
      end
    end
    render json: {posts: @@posts}
  end
end
