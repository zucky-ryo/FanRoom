class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:all, :search]

  # フォローしているユーザーの投稿一覧
  def index
    user_ids = current_user.followings.ids
    user_ids.push(current_user.id)
    @tweets = Tweet.where(user_id: user_ids).limit(50).includes(:user).order(created_at: "DESC")
  end

  # 全ユーザーの投稿一覧
  def all
    @tweets = Tweet.limit(50).includes(:user).order(created_at: "DESC")
  end

  # 全ユーザー中、検索に一致するユーザーの投稿一覧
  def search
    if params[:fan_team_id] != ""
      @fan_team = FanTeam.find(params[:fan_team_id])
      user_ids = @fan_team.users.ids
      @tweets = Tweet.where(user_id: user_ids).limit(50).includes(:user).order(created_at: "DESC")
    else
      redirect_to all_tweets_path
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  # 詳細ページ内でコメントの非同期通信を実装
  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order(created_at: "DESC")
  end

  # 投稿削除時に、ActiveStorageにある紐づいた画像・動画も削除
  def destroy
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user).order(created_at: "DESC")
    if @tweet.user == current_user
      @tweet.image.purge
      @tweet.destroy
      redirect_to tweets_path
    else
      render :show
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end
end
