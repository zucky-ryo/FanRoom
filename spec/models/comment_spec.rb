require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント機能' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    context 'コメント投稿がうまく行く時' do
      it 'コメントが存在する時投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿が失敗する時' do
      it 'コメントが存在しない時投稿できない' do
        @comment.content = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end
end
