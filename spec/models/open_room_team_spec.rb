require 'rails_helper'

RSpec.describe OpenRoomTeam, type: :model do
  describe '公開チャットルーム作成機能' do
    before do
      @open_room_team = FactoryBot.build(:open_room_team)
    end

    context 'ルーム作成がうまく行く時' do
      it 'ルーム名とチームタグが存在する時作成できる' do
        expect(@open_room_team).to be_valid
      end
      it 'チームタグが複数存在する時も作成できる' do
        @open_room_team.fan_team_id[0][:id] = 1
        @open_room_team.fan_team_id.push({id: 2})
        expect(@open_room_team).to be_valid
      end
      it 'ルーム名が20文字以内の時作成できる' do
        @open_room_team.name = "公開チャットルーム"
        expect(@open_room_team).to be_valid
      end
    end

    context 'ルーム作成が失敗する時' do
      it 'ルーム名が空の時作成できない' do
        @open_room_team.name = ""
        @open_room_team.valid?
        expect(@open_room_team.errors.full_messages).to include("ルーム名を入力してください")
      end
      it 'ルーム名が20文字以上の時作成できない' do
        @open_room_team.name = "abcdefghijklmnopqrstuvwxyz"
        @open_room_team.valid?
        expect(@open_room_team.errors.full_messages).to include("ルーム名は20文字以内で入力してください")
      end
      it 'チームタグが空の時作成できない' do
        @open_room_team.fan_team_id[0][:id] = ""
        @open_room_team.valid?
        expect(@open_room_team.errors.full_messages).to include("チームタグを入力してください")
      end
    end
  end
end
