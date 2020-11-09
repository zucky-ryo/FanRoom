$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/open_rooms/) && urlPath.match(/\d/)) {
    // 公開ルームを開いた時に自動で一番下にスクロール
    $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });

    // 公開ルームに参加した時にメッセージ入力フォームを表示させる
    $('#enter-room-btn').click(() => {
      const messageToken = '<input type="hidden" name="authenticity_token" value="Rihe8ErNK1zEge014G2oFAd/0YCt9IFDkD2PEvlEHYysJIJSiq11qO2eTLSG+0aDC+OYLTyiUuOd0iOnGk5tGw==">';
      const messageBox = '<input class="new-message-box" placeholder="メッセージを送信しよう！" type="text" name="open_message[content]" id="open_message_content">';
      const messageSubmit = '<input type="submit" name="commit" value="送信" class="new-message-submit" data-disable-with="送信">';
      $('#before-enter-text').css('display', 'none');
      $('#enter-room-btn').css('display', 'none');
      $('#open-chat-footer').append(messageToken);
      $('#open-chat-footer').append(messageBox);
      $('#open-chat-footer').append(messageSubmit);
    });

    // メッセージ入力欄を行数に合わせて広げる
    const textArea = $('#open_message_content');
    const roomFooter = $('#open-chat-footer');
    const boxHeight = parseInt(textArea.css('height'));
    const footerHeight = parseInt(roomFooter.css('height'));
    textArea.keyup(() => {
      const line = (textArea.val() + '\n').match(/\n/g).length;
      if (line < 6) {
        textArea.css('height', 30 * (line - 1) + boxHeight);
        roomFooter.css('height', 40 * (line - 1) + footerHeight);
      }
    });

    // メッセージ入力後Ctrl + Enter又は⌘ + Enterで送信
    $('#open_message_content').keydown((e) => {
      if ((e.ctrlKey || e.metaKey) && e.keyCode === 13) {
        $('#open-chat-footer').submit();
        return false;
      }
    });

    // ルームの詳細ボタンを押すと詳細が表示される
    $('#open-description').click(() => {
      $('#open-second-main').fadeIn(300).css('display','flex');
      $('#open-description').css('display', 'none');
      $('#open-description-close').css('display', 'block');
    });
    $('#open-description-close').click(() => {
      $('#open-second-main').fadeOut(300)
      $('#open-description-close').css('display', 'none');
      $('#open-description').css('display', 'block');
    });

    // 詳細のメンバーにカーソルを合わせるとメンバーリストが表示される
    $('#member-wrap').hover(
      () => {
        $('#member-list').css('display', 'block');
      },
      () => {
        $('#member-list').css('display', 'none');
      }
    );
  }
});

