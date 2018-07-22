class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.like(current_user)
    redirect_to root_path
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to root_path
  end
end
