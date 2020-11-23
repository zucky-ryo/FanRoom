module NewPrivateSupport
  def new_private(other_user)
    visit user_path(other_user.id)
    find(".simple-chat-btn").click
    expect(page.accept_confirm).to eq "#{other_user.nickname}さんにチャットを送信します"
  end
end
