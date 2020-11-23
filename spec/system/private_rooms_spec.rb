require "rails_helper"

RSpec.describe "プライベートチャットルーム作成機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, id: 2000, fan_team_id: 1)
    @private_room_member = FactoryBot.build(:private_room_member)
  end

  context 'プライベートチャットルームを作成できる時' do
    it '正しい情報を入力すればルームを作成できて作成したチャットルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      # 参加チャットルーム一覧ページに遷移するボタンがあることを確認する
      expect(page).to have_content('参加チャット')
      # 参加チャットルーム一覧ページに遷移する
      visit private_rooms_path
      # ルーム作成ページに遷移するボタンがあることを確認する
      expect(page).to have_content('ルーム作成')
      # ルーム作成ページに遷移する
      visit new_private_room_path
      # 正しい情報を入力する
      find("#private_room_member_user_ids_#{@other_user.id}").click
      # 新規作成ボタンを押すとプライベートルームモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { PrivateRoom.count }.by(1)
      # 作成したチャットルームのページに遷移していることを確認する
      private_room_id = PrivateRoom.all[-1].id
      expect(current_path).to eq private_room_path(private_room_id)
      # チャット相手の名前が表示されていることを確認する
      expect(page).to have_content("#{@other_user.nickname}")
    end
  end
  context 'プライベートチャットルームを作成できない時' do
    it '誤った情報ではルームを作成できずにプライベートチャットルーム作成ページに戻ってくる' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      # 参加チャットルーム一覧ページに遷移するボタンがあることを確認する
      expect(page).to have_content('参加チャット')
      # 参加チャットルーム一覧ページに遷移する
      visit private_rooms_path
      # ルーム作成ページに遷移するボタンがあることを確認する
      expect(page).to have_content('ルーム作成')
      # ルーム作成ページに遷移する
      visit new_private_room_path
      # 入力なしで新規作成ボタンを押してもプライベートルームモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { PrivateRoom.count }.by(0)
      # ルーム作成ページへ戻されることを確認する
      expect(current_path).to eq "/private_rooms"
    end
  end
end

RSpec.describe "プライベートチャットルーム簡易作成機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, id: 2000, fan_team_id: 1)
  end

  context 'プライベートチャットルームを簡易作成できる時' do
    it '既存のルームが存在しない場合ルームを作成できてそのルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      # フォローしたユーザーの詳細ページに遷移する
      visit user_path(@other_user.id)
      # ルーム簡易作成ボタンをクリックするとプライベートルームモデルのカウントが１上がることを確認する
      find(".simple-chat-btn").click
      expect{
        expect(page.accept_confirm).to eq "#{@other_user.nickname}さんにチャットを送信します"
        sleep 0.5
      }.to change { PrivateRoom.count }.by(1)
      # 作成したチャットルームのページに遷移していることを確認する
      private_room_id = PrivateRoom.all[-1].id
      expect(current_path).to eq private_room_path(private_room_id)
      # チャット相手の名前が表示されていることを確認する
      expect(page).to have_content("#{@other_user.nickname}")
    end
  end
  context 'プライベートチャットルームの簡易作成ができない時' do
    it '既存のルームが存在する場合そのルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      # フォローしたユーザーとのチャットルームを作成する
      new_private(@other_user)
      # フォローしたユーザーの詳細ページに遷移する
      visit user_path(@other_user.id)
      # ルーム簡易作成ボタンをクリックしてもプライベートルームモデルのカウントが上がらないことを確認する
      find(".simple-chat-btn").click
      expect{
        expect(page.accept_confirm).to eq "#{@other_user.nickname}さんにチャットを送信します"
        sleep 0.5
      }.to change { PrivateRoom.count }.by(0)
      # 作成したチャットルームのページに遷移していることを確認する
      private_room_id = PrivateRoom.all[-1].id
      expect(current_path).to eq private_room_path(private_room_id)
      # チャット相手の名前が表示されていることを確認する
      expect(page).to have_content("#{@other_user.nickname}")
    end
  end
end

RSpec.describe "プライベートチャットルーム編集機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, id: 2000, fan_team_id: 1)
  end

  context 'プライベートチャットルームを編集する時' do
    it '情報を入力すればルームを編集できてそのルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      # フォローしたユーザーとのチャットルームを作成する
      new_private(@other_user)
      # 参加チャットルーム一覧ページに遷移する
      visit private_rooms_path
      # 作成済みのルームページに遷移するボタンがあることを確認する
      expect(page).to have_content(@other_user.nickname)
      # 作成済みのルームページに遷移する
      private_room_id = PrivateRoom.all[-1].id
      visit private_room_path(private_room_id)
      # 詳細ボタンをクリックする
      find("#private-description").click
      # 編集ページに遷移するボタンがあることを確認する
      expect(page).to have_content("編集")
      # 編集ページに遷移する
      visit edit_private_room_path(private_room_id)
      # 新しい情報を入力する
      fill_in 'open-name', with: "変更後のルーム名"
      fill_in 'open-content', with: "変更後のルームメモ"
      # 保存するボタンを押す
      find('input[name="commit"]').click
      # 同じルームのページに遷移していることを確認する
      expect(current_path).to eq private_room_path(private_room_id)
      # 詳細ボタンをクリックする
      find("#private-description").click
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content("変更後のルーム名")
      expect(page).to have_content("変更後のルームメモ")
    end
  end
end

RSpec.describe "プライベートチャットルームメンバー追加機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, id: 2000, fan_team_id: 1)
    @other_user2 = FactoryBot.create(:user, id: 3000, fan_team_id: 1)
  end

  context 'プライベートチャットルームにメンバーを追加する時' do
    it '情報を入力すればルームを編集できてそのルームのページに遷移する' do
      # ログインする
      sign_in(@user)
      # 他ユーザーをフォローする
      user_follow(@other_user)
      user_follow(@other_user2)
      # フォローしたユーザーとのチャットルームを作成する
      new_private(@other_user)
      # 参加チャットルーム一覧ページに遷移する
      visit private_rooms_path
      # 作成済みのルームページに遷移するボタンがあることを確認する
      expect(page).to have_content(@other_user.nickname)
      # 作成済みのルームページに遷移する
      private_room_id = PrivateRoom.all[-1].id
      visit private_room_path(private_room_id)
      # 詳細ボタンをクリックする
      find("#private-description").click
      # メンバーを追加するボタンがあることを確認する
      expect(page).to have_content("追加")
      # 追加ボタンを押すとユーザー追加フォームが表示されることを確認する
      find("#add-member-btn").click
      expect(page).to have_content(@other_user.nickname)
      # 正しい情報を入力する
      find("#user_ids_#{@other_user2.id}").click
      # ルームに追加ボタンを押す
      find(".private-add-submit-btn").click
      # 同じルームのページに遷移していることを確認する
      expect(current_path).to eq private_room_path(private_room_id)
      # 詳細ボタンをクリックする
      find("#private-description").click
      find(".room-member-title").hover
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content(@other_user.nickname)
      expect(page).to have_content(@other_user2.nickname)
    end
  end
end

RSpec.describe "プライベートチャットルーム削除機能", type: :system do
  before do
    @private_room_user = FactoryBot.create(:private_room_user)
    FactoryBot.create_list(:private_message, 1, user_id: @private_room_user.user.id, private_room_id: @private_room_user.private_room.id)
  end
  
  it 'ルームから退出しメンバーが0人になるとルームが削除され、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@private_room_user.user)
    # 公開チャットルーム一覧ページに遷移する
    visit private_rooms_path
    # 作成されたチャットルームへ遷移する
    click_on("メンバーがいません")
    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:private_message, 5, user_id: @private_room_user.user.id, private_room_id: @private_room_user.private_room.id)
    # 詳細ボタンをクリックする
    find("#private-description").click
    # 退出ボタンをクリックすることで、初期メッセージ1つと作成した5つのメッセージが全て削除されていることを確認する
    find_link("退出",  href: exit_private_room_path(@private_room_user.private_room.id)).click
    expect{
      expect(page.accept_confirm).to eq "このルームから退出しますか？\n※ルームメンバーが0人になるとルームは自動的に削除されます"
      sleep 0.5
    }.to change { @private_room_user.private_room.private_messages.count }.by(-6)
    # 参加チャット一覧ページに遷移していることを確認する
    expect(current_path).to eq private_rooms_path
  end
end