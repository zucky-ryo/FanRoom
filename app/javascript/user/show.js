// users/show.html.erbで読み込まれるjsファイル
$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/users/) && urlPath.match(/\d/)) {
    // フォローボタンとフォロー解除ボタンを切り替える
    $('#follow-button').bind('ajax:success', () => {
      let followerNum = parseInt($('#user-followers').text());
      $('#follow-button').css('display', 'none');
      $('#unfollow-none').css('display', 'block');
      $('#user-followers').text(followerNum + 1);
    });
    $('#unfollow-none').bind('ajax:success', () => {
      let followerNum = parseInt($('#user-followers').text());
      $('#unfollow-none').css('display', 'none');
      $('#follow-button').css('display', 'block');
      $('#user-followers').text(followerNum - 1);
    });
    $('#unfollow-button').bind('ajax:success', () => {
      let followerNum = parseInt($('#user-followers').text());
      $('#unfollow-button').css('display', 'none');
      $('#follow-none').css('display', 'block');
      $('#user-followers').text(followerNum - 1);
    });
    $('#follow-none').bind('ajax:success', () => {
      let followerNum = parseInt($('#user-followers').text());
      $('#follow-none').css('display', 'none');
      $('#unfollow-button').css('display', 'block');
      $('#user-followers').text(followerNum + 1);
    });
  }
});