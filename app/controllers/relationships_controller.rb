class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    following.save
    redirect_to user_path(@user.id)
  end

  def destroy
    unfollowing = current_user.unfollow(@user)
    unfollowing.destroy
    redirect_to user_path(@user.id)
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
