$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/tweets/) && urlPath.match(/\d/)) {
    // コメント送信フォームの表示切り替え
    $('#tweet-comment-btn').click(() => {
      if ($('#comment-form').css('display') == 'none'){
        $('#comment-form').css('display', 'block');
      }else{
        $('#comment-form').css('display', 'none');
      }
    });
  }
});