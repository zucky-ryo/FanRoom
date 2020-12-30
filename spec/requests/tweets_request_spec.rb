require 'rails_helper'
describe TweetsController, type: :request do
  before do
    @tweet = FactoryBot.create(:tweet)
    sign_in @tweet.user
  end
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get tweets_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに作成済みツイートの画像または動画が存在する' do
      get tweets_path
      expect(response.body).to include @tweet.image.name
    end
  end

  describe "GET #all" do
    it 'allアクションにリクエストすると正常にレスポンスが返ってくる' do
      get all_tweets_path
      expect(response.status).to eq 200
    end
    it 'allアクションにリクエストするとレスポンスに作成済みツイートの画像または動画が存在する' do
      get all_tweets_path
      expect(response.body).to include @tweet.image.name
    end
  end

  describe "GET #search" do
    it 'searchアクションにリクエストすると正常にレスポンスが返ってくる' do
      get search_tweets_path(fan_team_id: 1)
      expect(response.status).to eq 200
    end
    it 'searchアクションにリクエストするとレスポンスに作成済みツイートの画像または動画が存在する' do
      get search_tweets_path(fan_team_id: 1)
      expect(response.body).to include @tweet.image.name
    end
  end

  describe "GET #new" do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
      get new_tweet_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get tweet_path(@tweet.id)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに作成済みツイートの画像または動画が存在する' do
      get tweet_path(@tweet.id)
      expect(response.body).to include @tweet.image.name
    end
  end

end
