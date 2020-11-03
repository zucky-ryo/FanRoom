require "rails_helper"
describe UsersController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end
  describe "GET #show" do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get user_path(@user.id)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスにユーザーのnicknameが存在する' do
      get user_path(@user.id)
      expect(response.body).to include @user.nickname
    end
    it 'showアクションにリクエストするとレスポンスにユーザーのファンチーム名が存在する' do
      get user_path(@user.id)
      expect(response.body).to include @user.fan_team.team_name
    end
  end
end
