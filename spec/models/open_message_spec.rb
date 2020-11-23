require 'rails_helper'

RSpec.describe OpenMessage, type: :model do
  describe '公開チャットルームのメッセージ送信機能' do
    before do
      @open_message = FactoryBot.build(:open_message)
    end

    context 'メッセージ送信がうまく行く時' do
      it 'contentが存在する時送信できる' do
        expect(@open_message).to be_valid
      end
    end

    context 'メッセージ送信が失敗する時' do
      it 'contentが空の時送信できない' do
        @open_message.content = ""
        @open_message.valid?
        expect(@open_message.errors.full_messages).to include("Contentを入力してください")
      end
    end
  end
end
