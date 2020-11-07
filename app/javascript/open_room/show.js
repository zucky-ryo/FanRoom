$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/open_rooms/) && urlPath.match(/\d/)) {
    // 公開ルームを開いた時に自動で一番下にスクロール
    $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });

    
  }
});