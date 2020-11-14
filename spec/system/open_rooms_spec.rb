require "rails_helper"

RSpec.describe "公開チャットルーム作成機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @open_room_team = FactoryBot.build(:open_room_team)
  end

  context '公開チャットルームを作成できる時' do
    it '正しい情報を入力すればルームを作成できて作成したチャットルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 公開チャットルーム一覧ページに遷移するボタンがあることを確認する
      expect(page).to have_content('公開チャット')
      # 公開チャットルーム一覧ページに遷移する
      visit open_rooms_path
      # ルーム作成ページに遷移するボタンがあることを確認する
      expect(page).to have_content('作成')
      # ルーム作成ページに遷移する
      visit new_open_room_path
      # 正しい情報を入力する
      fill_in 'open-name', with: "公開チャットルーム"
      select "阪神タイガース", from: "open-new-team"
      # 新規作成ボタンを押すとオープンルームモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { OpenRoom.count }.by(1)
      # 作成したチャットルームのページに遷移していることを確認する
      open_room_id = OpenRoom.all[-1].id
      expect(current_path).to eq open_room_path(open_room_id)
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content("公開チャットルーム")
    end
  end
  context '公開チャットルームを作成できない時' do
    it '誤った情報ではルームを作成できずに公開チャットルーム作成ページに戻ってくる' do
      # ログインする
      sign_in(@user)
      # 公開チャットルーム一覧ページに遷移するボタンがあることを確認する
      expect(page).to have_content('公開チャット')
      # 公開チャットルーム一覧ページに遷移する
      visit open_rooms_path
      # ルーム作成ページに遷移するボタンがあることを確認する
      expect(page).to have_content('作成')
      # ルーム作成ページに遷移する
      visit new_open_room_path
      # 誤った情報を入力する
      fill_in 'open-name', with: ""
      select "--", from: "open-new-team"
      # 新規作成ボタンを押してもオープンルームモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { OpenRoom.count }.by(0)
      # ルーム作成ページへ戻されることを確認する
      expect(current_path).to eq "/open_rooms"
    end
  end
end

RSpec.describe "公開チャットルーム編集機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @open_room = FactoryBot.create(:open_room)
    @open_room_team = FactoryBot.build(:open_room_team)
  end

  context '公開チャットルームを編集できる時' do
    it '正しい情報を入力すればルームを編集できてそのルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 公開チャットルーム一覧ページに遷移するボタンがあることを確認する
      expect(page).to have_content('公開チャット')
      # 公開チャットルーム一覧ページに遷移する
      visit open_rooms_path
      # 作成済みのルームページに遷移するボタンがあることを確認する
      expect(page).to have_content(@open_room.name)
      # 作成済みのルームページに遷移する
      visit open_room_path(@open_room.id)
      # 入室ボタンをクリックする
      find(".enter-open-room").click
      # 詳細ボタンをクリックする
      find("#open-description").click
      # 編集ページに遷移するボタンがあることを確認する
      expect(page).to have_content("編集")
      # 編集ページに遷移する
      visit edit_open_room_path(@open_room.id)
      # 新しい情報を入力する
      fill_in 'open-name', with: "変更後のルーム名"
      fill_in 'open-content', with: "変更後のルームメモ"
      # 保存するボタンを押す
      find('input[name="commit"]').click
      # 同じルームのページに遷移していることを確認する
      expect(current_path).to eq open_room_path(@open_room.id)
      # 詳細ボタンをクリックする
      find("#open-description").click
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content("変更後のルーム名")
      expect(page).to have_content("変更後のルームメモ")
      # 編集前の情報が表示されていないことを確認する
      expect(page).to have_no_content(@open_room.name)
      expect(page).to have_no_content(@open_room.description)
    end
  end
  context '公開チャットルームを編集できない時' do
    it '誤った情報ではルームを編集できずに編集ページに戻ってくる' do
      # ログインする
      sign_in(@user)
      # 公開チャットルーム一覧ページに遷移するボタンがあることを確認する
      expect(page).to have_content('公開チャット')
      # 公開チャットルーム一覧ページに遷移する
      visit open_rooms_path
      # 作成済みのルームページに遷移するボタンがあることを確認する
      expect(page).to have_content(@open_room.name)
      # 作成済みのルームページに遷移する
      visit open_room_path(@open_room.id)
      # 入室ボタンをクリックする
      find(".enter-open-room").click
      # 詳細ボタンをクリックする
      find("#open-description").click
      # 編集ページに遷移するボタンがあることを確認する
      expect(page).to have_content("編集")
      # 編集ページに遷移する
      visit edit_open_room_path(@open_room.id)
      # 誤った情報を入力する
      fill_in 'open-name', with: ""
      # 保存するボタンを押す
      find('input[name="commit"]').click
      # ルーム編集ページに戻されることを確認する
      expect(current_path).to eq "/open_rooms/#{@open_room.id}"
    end
  end
end