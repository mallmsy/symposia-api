require 'rest-client'

class PostsController < ApplicationController
  skip_before_action :authorized, only: [:create, :index, :fetch_articles, :destroy]

  API_KEY = "cba4b9a885984bc49ddefc159d1fbb23"
  LEFT_SOURCES = "cnn,the-new-york-times,cbs-news"
  CENTER_SOURCES = "bbc-news,al-jazeera-english,the-wall-street-journal"
  RIGHT_SOURCES = "fox-news,breitbart-news,national-review"

  CATEGORIES = ["CLIMATE", "IMMIGRATION", "2020", "NATIONAL+DEBT", "ABORTION", "BORDER" ]


  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      render json: @post
    else
      render json: { error: 'failed to create post' }
    end
  end

  def destroy
    @post = find_post
    @post.destroy
    render json: {message: "DELETED"}
  end

  def fetch_articles
    @new_posts = []

    CATEGORIES.each do |topic|
      news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{LEFT_SOURCES}&pageSize=5&apiKey=#{API_KEY}"
      response = JSON.parse( RestClient.get("#{news_url}"))
      articles = response["articles"]

      articles.each do |article|
        Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"],  slant: "left", topic: topic ) do |post|
          @new_posts << post
        end
      end
    end

    CATEGORIES.each do |topic|
      news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{CENTER_SOURCES}&pageSize=5&apiKey=#{API_KEY}"
      response = JSON.parse( RestClient.get("#{news_url}"))
      articles = response["articles"]

      articles.each do |article|
        Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "center", topic: topic ) do |post|
          @new_posts << post
        end
      end
    end

    CATEGORIES.each do |topic|
      news_url = "https://newsapi.org/v2/everything?q=#{topic}&sources=#{RIGHT_SOURCES}&pageSize=5&apiKey=#{API_KEY}"
      response = JSON.parse( RestClient.get("#{news_url}"))
      articles = response["articles"]

      articles.each do |article|
        Post.find_or_create_by!(title: article["title"], description: article["description"], publish_date: article["publishedAt"], author: article["author"], content: article["content"], source: article["source"]["name"], img_url: article["urlToImage"], link: article["url"], slant: "right", topic: topic ) do |post|
          @new_posts << post
        end
      end
    end
    render json: {message: "new posts", posts: @new_posts}
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :publish_date, :author, :content, :source, :img_url, :slant, :topic)
  end
end
