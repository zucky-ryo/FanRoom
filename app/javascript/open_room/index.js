$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/open_rooms/)) {
    $('#header-open-room').css('background', 'yellow');
  }
});