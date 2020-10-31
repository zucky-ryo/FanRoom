class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to user_path(@user.id)
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to user_path(@user.id)
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
