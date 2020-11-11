class RelationshipsController < ApplicationController

  # フォロー機能（userモデルのメソッドを利用）
  def create
    @user = User.find(params[:format])
    following = current_user.follow(@user)
    if following.save
      render json: [id: @user.id]
    else
      render json: [id: @user.id], status: 500
    end
  end

  # フォロー解除（userモデルのメソッドを利用）
  def destroy
    @user = User.find(params[:id])
    unfollowing = current_user.unfollow(@user)
    if unfollowing != nil
      unfollowing.destroy
      render json: [id: @user.id]
    else
      render json: [id: @user.id], status: 500
    end
  end
end
