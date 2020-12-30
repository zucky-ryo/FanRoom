require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'ツイート投稿機能' do
    before do
      @tweet = FactoryBot.build(:tweet)
    end

    context 'ツイート投稿がうまく行く時' do
      it '画像または動画が存在する時投稿できる' do
        expect(@tweet).to be_valid
      end
    end

    context 'ツイート投稿が失敗する時' do
      it '画像または動画が存在しない時投稿できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("画像または動画を入力してください")
      end
      it '画像または動画の拡張子が(.png, .jpg, .gif, .mp4)以外の時投稿できない' do
        @tweet.image.content_type = "image/pdf"
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("画像または動画は(.png .jpg .gif .mp4)から選択してください")
      end
    end
  end
end
