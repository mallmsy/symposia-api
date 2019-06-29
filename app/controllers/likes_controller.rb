class LikesController < ApplicationController

  def create
    @like = Like.create(like_params)
    render json: @like
  end

  def destroy
    @like = find_like
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end

  def find_like
    @like = Like.find(params[:id])
  end
end
