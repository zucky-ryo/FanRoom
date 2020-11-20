require 'rails_helper'

RSpec.describe PrivateRoomMember, type: :model do
  describe 'プライベートチャットルーム作成機能' do
    before do
      @private_room_member = FactoryBot.build(:private_room_member)
    end

    context 'ルーム作成がうまく行く時' do
      it 'ルームメンバーが存在する時作成できる' do
        expect(@private_room_member).to be_valid
      end
      it 'ルームメンバーが3人以上の時も作成できる' do
        @private_room_member.user_ids = ["", 1, 2, 3]
        expect(@private_room_member).to be_valid
      end
      it 'ルーム名が20文字以内の時作成できる' do
        @private_room_member.name = "公開チャットルーム"
        expect(@private_room_member).to be_valid
      end
    end

    context 'ルーム作成が失敗する時' do
      it 'ルームメンバーが2人未満の時作成できない' do
        @private_room_member.user_ids = ["", 1]
        @private_room_member.valid?
        expect(@private_room_member.errors.full_messages).to include("ルームメンバーを選択してください")
      end
      it 'ルーム名が20文字以上の時作成できない' do
        @private_room_member.name = "abcdefghijklmnopqrstuvwxyz"
        @private_room_member.valid?
        expect(@private_room_member.errors.full_messages).to include("ルーム名は20文字以内で入力してください")
      end
    end
  end
end
