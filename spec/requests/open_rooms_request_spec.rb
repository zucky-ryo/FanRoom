require 'rails_helper'
describe OpenRoomsController, type: :request do
  before do
    @open_room_user = FactoryBot.create(:open_room_user)
    FactoryBot.create_list(:open_message, 1, user_id: @open_room_user.user.id, open_room_id: @open_room_user.open_room.id)
    sign_in @open_room_user.user
  end
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get open_rooms_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに作成済みルームのルーム名が存在する' do
      get open_rooms_path
      expect(response.body).to include @open_room_user.open_room.name
    end
  end

  describe "GET #new" do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
      get new_open_room_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get open_room_path(@open_room_user.open_room.id)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスにルーム名が存在する' do
      get open_room_path(@open_room_user.open_room.id)
      expect(response.body).to include @open_room_user.open_room.name
    end
    it 'showアクションにリクエストするとレスポンスにルーム内のメッセージが存在する' do
      get open_room_path(@open_room_user.open_room.id)
      expect(response.body).to include @open_room_user.open_room.open_messages[0].content
    end
  end

  describe "GET #edit" do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
      get edit_open_room_path(@open_room_user.open_room.id)
      expect(response.status).to eq 200
    end
  end
end
