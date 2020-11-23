require "rails_helper"

RSpec.describe "フォローフォロワー機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, id: 2000, fan_team_id: 1)
  end

  context '他ユーザーをフォローする時' do
    it '他ユーザーの詳細ページでフォローボタンを押すとそのユーザーをフォローする' do
      # ログインする
      sign_in(@user)
      # 他ユーザーの詳細ページに遷移する
      visit user_path(@other_user.id)
      # 詳細ページにフォローするボタンがあることを確認する
      expect(page).to have_content('フォローする')
      # フォローボタンをクリックするとrelationshipモデルのカウントが１上がることを確認する
      expect{
        find(".follow-btn").click
        sleep 0.5
      }.to change { Relationship.count }.by(1)
      # ページ遷移していないことを確認する
      expect(current_path).to eq user_path(@other_user.id)
      # フォロー解除ボタンが表示されていることを確認する
      expect(page).to have_content("フォロー解除")
    end
  end
  context '他ユーザーをフォロー解除する時' do
    it '他ユーザーの詳細ページでフォロー解除ボタンを押すとそのユーザーのフォローを解除する' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      # 他ユーザーの詳細ページに遷移する
      visit user_path(@other_user.id)
      # 詳細ページにフォローを解除するボタンがあることを確認する
      expect(page).to have_content('フォロー解除')
      # フォロー解除ボタンをクリックするとrelationshipモデルのカウントが１下がることを確認する
      find(".unfollow-btn").click
      expect{
        expect(page.accept_confirm).to eq "#{@other_user.nickname}さんのフォローを解除します"
        sleep 0.5
      }.to change { Relationship.count }.by(-1)
      # ページ遷移していないことを確認する
      expect(current_path).to eq user_path(@other_user.id)
      # フォロー解除ボタンが表示されていることを確認する
      expect(page).to have_content("フォローする")
    end
  end
end