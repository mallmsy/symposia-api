require 'rest-client'

class PostsController < ApplicationController
  API_KEY = "cba4b9a885984bc49ddefc159d1fbb23"
  ALL_SOURCES = ["cnn","the-new-york-times","cbs-news","bbc-news","al-jazeera-english","the-wall-street-journal","fox-news","breitbart-news","national-review"]

  def index
    @posts = Post.all
    render json: @posts
  end

  def fetch_posts
    news_url = "https://newsapi.org/v2/everything?sources=#{ALL_SOURCES}&pageSize=100&apiKey=#{API_KEY}"
    @data = JSON.parse( RestClient.get("#{news_url}"))
    byebug
    render json: @data
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      render json: @post
    else
      render json: { error: 'failed to create post' }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :publish_date, :author, :content, :source, :img_url, :slant)
  end
end
