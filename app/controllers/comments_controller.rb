class CommentsController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def create
    @comment = Comment.create(comment_params)
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    CommentsChannel.broadcast_to(@post, {type: 'ADD_COMMENT', payload: prep_comment(@comment, @user)})
    render json: @comment
  end

  def update
    @comment = find_comment
    @user = User.find(@comment[:user_id])
    @post = Post.find(@comment[:post_id])
    @comment.update(comment_params)
    if @comment.save
      CommentsChannel.broadcast_to(@post, {type: 'UPDATE_COMMENT', payload: prep_comment(@comment, @user)})
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @comment = find_comment
    @user = User.find(@comment[:user_id])
    @post = Post.find(@comment[:post_id])
    @comment.destroy
    CommentsChannel.broadcast_to(@post, {type: 'REMOVE_COMMENT', payload: prep_comment(@comment, @user)})
    render json: @comment
  end

  private

  def prep_comment(comment, user)
    comment_hash = {
      content: comment.content,
      id: comment.id,
      post_id: comment.post_id,
      user: user
    }
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
