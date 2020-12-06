$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/tweets/) && urlPath.match(/\d/) == null && urlPath.match(/new/) == null) {
    $('#header-tweet').css('background', 'yellow');
    $('#tweet-search-current').css('background', 'yellow');
  }
});