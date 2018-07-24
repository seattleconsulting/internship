class LikesController < ApplicationController
  def create
    current_user.like(params[:micropost_id])
    redirect_to root_path
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to root_path
  end
end
