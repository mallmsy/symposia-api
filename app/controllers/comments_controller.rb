class CommentsController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def create
    @comment = Comment.create(comment_params)
    render json: @comment
  end

  def update
    @comment = find_comment
    @comment.update(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @comment = find_comment
    @comment.destroy
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
