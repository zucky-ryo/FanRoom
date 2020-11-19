$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/private_rooms/) && urlPath.match(/\d/)) {
    // 公開ルームを開いた時に自動で一番下にスクロール
    $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });

    // メッセージ入力欄を行数に合わせて広げる
    const textArea = $('#private_message_content');
    const roomFooter = $('#private-chat-footer');
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
    $('#private_message_content').keydown((e) => {
      if ((e.ctrlKey || e.metaKey) && e.keyCode === 13) {
        $('#private-chat-footer').submit();
        return false;
      }
    });

    // ルームの詳細ボタンを押すと詳細が表示される
    $('#private-description').click(() => {
      $('#private-second-main').fadeIn(300).css('display','flex');
      $('#private-description').css('display', 'none');
      $('#private-description-close').css('display', 'block');
    });
    $('#private-description-close').click(() => {
      $('#private-second-main').fadeOut(200);
      $('#private-third-main').fadeOut(500);
      $('#private-description-close').css('display', 'none');
      $('#private-description').css('display', 'block');
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

    $('#add-member-btn').click(() => {
      $('#private-third-main').fadeIn(300).css('display','flex');
    });
  }
});

