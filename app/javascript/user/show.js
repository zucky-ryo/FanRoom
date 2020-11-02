// users/show.html.erbで読み込まれるjsファイル
$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/users/) && urlPath.match(/\d/)) {
    const followBtn = $('#follow-button');
    const unfollowBtn = $('#unfollow-button');
    const followers = $('#user-followers');
    const currentName = $("#current-name").html();
    const currentNameText = $("#current-name").text();
    const followingLists = $('#user-following-lists');
    const followerLists = $('#user-follower-lists');
    const followingUser = $('#following-user');
    const followerUser = $('#follower-user');

    // マイページの時ヘッダーのボタンを光らせる
    if (currentNameText == $('#user-nickname').text().trim()){
      $('#header-mypage').css('background', 'yellow');
    }

    // フォローボタンとフォロー解除ボタンを切り替えて、リストに追加・削除する
    followBtn.bind('ajax:success', () => {
      let followerNum = parseInt(followers.text());
      followBtn.css('display', 'none');
      unfollowBtn.css('display', 'block');
      followers.text(followerNum + 1);
      followerLists.prepend(`<div class="follower-list" id="user-follower-list">${currentName}</div>`);
    });
    unfollowBtn.bind('ajax:success', () => {
      let followerNum = parseInt(followers.text());
      unfollowBtn.css('display', 'none');
      followBtn.css('display', 'block');
      followers.text(followerNum - 1);
      $('.follower-list').each((index, element) => {
        if ($(element).text().trim() == currentNameText){
          $(element).remove();
        }
      });
    });

    // フォロー/フォロワーをクリックした時リストを表示させる
    followingUser.click(() => {
      if (followingLists.css('display') == 'none'){
        followingUser.css('background', 'rgb(253, 54, 28)');
        followingLists.css('display', 'block');
        followerUser.css('background', 'rgb(255, 123, 0)');
        followerLists.css('display', 'none');
      }else{
        followingUser.css('background', 'rgb(255, 123, 0)');
        followingLists.css('display', 'none');
      }
    });
    followerUser.click(() => {
      if (followerLists.css('display') == 'none'){
        followerUser.css('background', 'rgb(253, 54, 28)');
        followerLists.css('display', 'block');
        followingUser.css('background', 'rgb(255, 123, 0)');
        followingLists.css('display', 'none');
      }else{
        followerUser.css('background', 'rgb(255, 123, 0)');
        followerLists.css('display', 'none');
      }
    });
  }
});