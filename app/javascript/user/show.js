// users/show.html.erbで読み込まれるjsファイル
$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/users/) && urlPath.match(/\d/)) {
    // フォローボタンとフォロー解除ボタンを切り替える
    $('#follow-button').click(() => {
      $('#follow-button').css('display', 'none');
      $('#unfollow-none').css('display', 'block');
    });
    $('#unfollow-none').click(() => {
      $('#unfollow-none').css('display', 'none');
      $('#follow-button').css('display', 'block');
    });
    $('#unfollow-button').click(() => {
      $('#unfollow-button').css('display', 'none');
      $('#follow-none').css('display', 'block');
    });
    $('#follow-none').click(() => {
      $('#follow-none').css('display', 'none');
      $('#unfollow-button').css('display', 'block');
    });
  }
});