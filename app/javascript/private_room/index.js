$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/private_rooms/) && urlPath.match(/\d/) == null && urlPath.match(/new/) == null) {
    $('#header-my-room').css('background', 'yellow');
  }
});