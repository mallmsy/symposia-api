
class PostsController < ApplicationController
  skip_before_action :authorized, only: [:create, :index]


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

  private

  def post_params
    params.require(:post).permit(:title, :description, :publish_date, :author, :content, :source, :img_url, :slant, :topic)
  end
end
