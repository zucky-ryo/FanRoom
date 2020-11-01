// users/show.html.erbで読み込まれるjsファイル
$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/users/) && urlPath.match(/\d/)) {
    // フォローボタンとフォロー解除ボタンを切り替えて、リストに追加・削除する
    const followBtn = $('#follow-button');
    const unfollowBtn = $('#unfollow-button');
    const followers = $('#user-followers');

    followBtn.bind('ajax:success', () => {
      let followerNum = parseInt(followers.text());
      followBtn.css('display', 'none');
      unfollowBtn.css('display', 'block');
      followers.text(followerNum + 1);
    });
    unfollowBtn.bind('ajax:success', () => {
      let followerNum = parseInt(followers.text());
      unfollowBtn.css('display', 'none');
      followBtn.css('display', 'block');
      followers.text(followerNum - 1);
    });


    // フォロー/フォロワーをクリックした時リストを表示させる
    const followingUser = $('#following-user');
    const followingList = $('#user-following-lists');
    const followerUser = $('#follower-user');
    const followerList = $('#user-follower-lists')

    followingUser.click(() => {
      if (followingList.css('display') == 'none'){
        followingUser.css('background', 'rgb(253, 54, 28)');
        followingList.css('display', 'block');
        followerUser.css('background', 'rgb(255, 123, 0)');
        followerList.css('display', 'none');
      }else{
        followingUser.css('background', 'rgb(255, 123, 0)');
        followingList.css('display', 'none');
      }
    });
    followerUser.click(() => {
      if (followerList.css('display') == 'none'){
        followerUser.css('background', 'rgb(253, 54, 28)');
        followerList.css('display', 'block');
        followingUser.css('background', 'rgb(255, 123, 0)');
        followingList.css('display', 'none');
      }else{
        followerUser.css('background', 'rgb(255, 123, 0)');
        followerList.css('display', 'none');
      }
    });
  }
});