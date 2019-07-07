class PostsController < ApplicationController
  skip_before_action :authorized, only: [:create, :index]


  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      PostsChannel
    else
      render json: { error: 'failed to create post' }
    end
  end

  def destroy
    @post = find_post
    @post.destroy
    render json: {message: "DELETED"}
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :publish_date, :author, :content, :source, :img_url, :slant, :topic)
  end
end
