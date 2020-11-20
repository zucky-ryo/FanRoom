require 'rails_helper'

RSpec.describe PrivateMessage, type: :model do
  describe 'プライベートチャットルームのメッセージ送信機能' do
    before do
      @private_message = FactoryBot.build(:private_message)
    end

    context 'メッセージ送信がうまく行く時' do
      it 'contentが存在する時送信できる' do
        expect(@private_message).to be_valid
      end
    end

    context 'メッセージ送信が失敗する時' do
      it 'contentが空の時送信できない' do
        @private_message.content = ""
        @private_message.valid?
        expect(@private_message.errors.full_messages).to include("Contentを入力してください")
      end
    end
  end
end
