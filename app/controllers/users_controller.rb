class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # フォロー、フォロワーを新しい順に表示させる
    @followings = @user.followings.includes(:relationships).order("relationships.created_at DESC")
    @followers = @user.followers.includes(:relationships).order("relationships.created_at DESC")
  end
end
