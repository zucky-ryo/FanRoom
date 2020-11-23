require 'rails_helper'

RSpec.describe OpenRoom, type: :model do
  describe '公開チャットルーム更新機能' do
    before do
      @open_room = FactoryBot.build(:open_room)
    end

    context '公開チャットルーム更新がうまく行く時' do
      it 'ルーム名が20文字以内で存在する時保存できる' do
        @open_room.name = "更新後のルーム名"
        expect(@open_room).to be_valid
      end
    end

    context '公開チャットルーム更新が失敗する時' do
      it 'ルーム名が空の時保存できない' do
        @open_room.name = ""
        @open_room.valid?
        expect(@open_room.errors.full_messages).to include("ルーム名を入力してください")
      end
      it 'ルーム名が20文字以上の時保存できない' do
        @open_room.name = "アイウエオかきくけこサシスセソたちつてとナニヌネノ"
        @open_room.valid?
        expect(@open_room.errors.full_messages).to include("ルーム名は20文字以内で入力してください")
      end
    end
  end
end
