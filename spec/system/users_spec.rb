require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    FanTeam.create(id: "1", team_name: "阪神タイガース")
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてマイページに遷移する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページに遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      select "阪神タイガース", from: "user_fan_team_id"
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password
      # ユーザー登録ボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # マイページへ遷移する
      expect(current_path).to include("/users/")
      # ログアウトボタンがあることを確認する
      expect(page).to have_content("ログアウト")
      # 新規登録ページとログインページに遷移するボタンがそれぞれ表示されてないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページに遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ""
      select "--", from: "user_fan_team_id"
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      fill_in 'password-confirmation', with: ""
      # ユーザー登録ボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ユーザーログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ユーザーログインができる時' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページに遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページに移動する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # マイページへ遷移することを確認する
      expect(current_path).to include("/users/")
      # ログアウトボタンがあることを確認する
      expect(page).to have_content("ログアウト")
      # 新規登録ページとログインページに遷移するボタンがそれぞれ表示されてないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context 'ユーザーログインができない時' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページに遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページに移動する
      visit new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "ユーザー編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
    FanTeam.create(id: "2", team_name: "中日ドラゴンズ")
  end

  context 'ユーザー編集ができる時' do
    it '正しい情報を入力すればユーザー編集ができてマイページに遷移する' do
      # ログインする
      sign_in(@user)
      # 編集ページに遷移するボタンがあることを確認する
      expect(page).to have_content('変更')
      # 編集ページに遷移する
      visit edit_user_registration_path
      # メールアドレス及びパスワードを変更するをクリックする
      find("#detail-btn").click
      # 新しい情報を入力する
      fill_in 'nickname', with: "oshima"
      select "中日ドラゴンズ", from: "user_fan_team_id"
      fill_in 'email', with: "test11@gmail.com"
      fill_in 'password', with: "test11"
      fill_in 'password-confirmation', with: "test11"
      fill_in 'current-password', with: @user.password
      # 更新するボタンを押す
      find('input[name="commit"]').click
      # マイページに遷移していることを確認する
      expect(current_path).to eq user_path(@user.id)
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content("oshima")
      expect(page).to have_content("中日ドラゴンズ")
      # 編集前の情報が表示されていないことを確認する
      expect(page).to have_no_content(@user.nickname)
      expect(page).to have_no_content(@user.fan_team.team_name)
    end
  end
  context 'ユーザー編集ができない時' do
    it '誤った情報ではユーザー編集ができない' do
      # ログインする
      sign_in(@user)
      # 編集ページに遷移するボタンがあることを確認する
      expect(page).to have_content('変更')
      # 編集ページに遷移する
      visit edit_user_registration_path
      # 誤った情報を入力する
      fill_in 'nickname', with: ""
      select "--", from: "user_fan_team_id"
      # 更新するボタンを押す
      find('input[name="commit"]').click
      # 編集ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end