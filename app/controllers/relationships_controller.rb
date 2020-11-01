class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:format])
    following = current_user.follow(@user)
    following.save
    render json: [id: @user.id]
  end

  def destroy
    @user = User.find(params[:id])
    unfollowing = current_user.unfollow(@user)
    unless unfollowing == nil
      unfollowing.destroy
    end
    render json: [id: @user.id]
  end
end
