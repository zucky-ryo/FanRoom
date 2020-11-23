require 'rails_helper'
describe PrivateRoomsController, type: :request do
  before do
    @private_room_user = FactoryBot.create(:private_room_user)
    FactoryBot.create_list(:private_message, 1, user_id: @private_room_user.user.id, private_room_id: @private_room_user.private_room.id)
    sign_in @private_room_user.user
  end
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get private_rooms_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
      get new_private_room_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get private_room_path(@private_room_user.private_room.id)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスにルーム名が存在する' do
      get private_room_path(@private_room_user.private_room.id)
      expect(response.body).to include @private_room_user.private_room.name
    end
    it 'showアクションにリクエストするとレスポンスにルーム内のメッセージが存在する' do
      get private_room_path(@private_room_user.private_room.id)
      expect(response.body).to include @private_room_user.private_room.private_messages[0].content
    end
  end

  describe "GET #edit" do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
      get edit_private_room_path(@private_room_user.private_room.id)
      expect(response.status).to eq 200
    end
  end
end
