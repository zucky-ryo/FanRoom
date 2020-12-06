$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/tweets/) && urlPath.match(/\d/)) {
    $('#tweet-comment-btn').click(() => {
      if ($('#comment-form').css('display') == 'none'){
        $('#comment-form').css('display', 'block');
      }else{
        $('#comment-form').css('display', 'none');
      }
    });
  }
});