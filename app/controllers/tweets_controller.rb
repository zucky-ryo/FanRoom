class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:all, :search]

  def index
    user_ids = current_user.followings.ids
    user_ids.push(current_user.id)
    @tweets = Tweet.where(user_id: user_ids).limit(50).includes(:user).order(created_at: "DESC")
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

  def all
    @tweets = Tweet.limit(50).includes(:user).order(created_at: "DESC")
  end

  def search
    if params[:fan_team_id] != ""
      @fan_team = FanTeam.find(params[:fan_team_id])
      user_ids = @fan_team.users.ids
      @tweets = Tweet.where(user_id: user_ids).limit(50).includes(:user).order(created_at: "DESC")
    else
      redirect_to all_tweets_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end
end
