$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/open_rooms/) && urlPath.match(/\d/)) {
    // 公開ルームを開いた時に自動で一番下にスクロール
    $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });

    // 公開ルームに参加した時にメッセージ入力フォームを表示させる
    $('#enter-room-btn').click(() => {
      const messageToken = '<input type="hidden" name="authenticity_token" value="Rihe8ErNK1zEge014G2oFAd/0YCt9IFDkD2PEvlEHYysJIJSiq11qO2eTLSG+0aDC+OYLTyiUuOd0iOnGk5tGw==">'
      const messageBox = '<input class="new-message-box" placeholder="メッセージを送信しよう！" type="text" name="open_message[content]" id="open_message_content">'
      const messageSubmit = '<input type="submit" name="commit" value="送信" class="new-message-submit" data-disable-with="送信">'
      $('#before-enter-text').css('display', 'none');
      $('#enter-room-btn').css('display', 'none');
      $('#open-chat-footer').append(messageToken);
      $('#open-chat-footer').append(messageBox);
      $('#open-chat-footer').append(messageSubmit);
    });
  }
});

