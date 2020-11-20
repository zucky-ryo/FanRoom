// users/show.html.erbで読み込まれるjsファイル
$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/users/) && urlPath.match(/\d/)) {
    const followBtn = $('#follow-button');
    const unfollowBtn = $('#unfollow-button');
    const simpleChatBtn = $('#simple-chat-button');
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

    // フォローボタンとフォロー解除ボタンを切り替えて、リストに追加・削除する（簡易ルーム作成ボタンも切り替える）
    followBtn.bind('ajax:success', () => {
      let followerNum = parseInt(followers.text());
      followBtn.css('display', 'none');
      unfollowBtn.css('display', 'block');
      simpleChatBtn.css('display', 'block');
      followers.text(followerNum + 1);
      followerLists.prepend(`<div class="follower-list" id="user-follower-list">${currentName}</div>`);
    });
    unfollowBtn.bind('ajax:success', () => {
      let followerNum = parseInt(followers.text());
      unfollowBtn.css('display', 'none');
      followBtn.css('display', 'block');
      simpleChatBtn.css('display', 'none');
      followers.text(followerNum - 1);
      $('.follower-list').each((index, element) => {
        if ($(element).text().trim() == currentNameText){
          $(element).remove();
        }
      });
    });

    // フォローフォロワーボタンにカーソルを合わせるとリストを表示
    followingUser.hover(
      () => {
        followingUser.css('background', 'rgb(253, 54, 28)');
        followingUser.css('box-shadow', 'none');
        followingLists.css('display', 'block');
      },
      () => {
        followingUser.css('background', 'rgb(255, 123, 0)');
        followingUser.css('box-shadow', 'gray 1px 1px');
        followingLists.css('display', 'none');
      }
    );
    followerUser.hover(
      () => {
        followerUser.css('background', 'rgb(253, 54, 28)');
        followerUser.css('box-shadow', 'none');
        followerLists.css('display', 'block');
      },
      () => {
        followerUser.css('background', 'rgb(255, 123, 0)');
        followerUser.css('box-shadow', 'gray 1px 1px');
        followerLists.css('display', 'none');
      }
    );
  }
});