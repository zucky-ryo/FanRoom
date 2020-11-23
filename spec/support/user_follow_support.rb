module UserFollowSupport
  def user_follow(other_user)
    visit user_path(other_user.id)
    find(".follow-btn").click
  end
end
