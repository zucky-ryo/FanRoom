import consumer from "./consumer"

consumer.subscriptions.create("OpenMessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // メッセージ送信時にすぐ表示（本人が送信した場合と他人が送信した場合に表示を分ける）
  received(data) {
    const urlPath = location.pathname;
    if (urlPath == '/open_rooms/' + data.content.open_room_id.toString()) {
      const japanStandardTime = new Date().toLocaleString({ timeZone: 'Asia/Tokyo' });
      const hours = new Date(japanStandardTime).getHours();
      const minutes = new Date(japanStandardTime).getMinutes().toString().padStart(2, '0');
      const userId = data.content.user_id;
      const currentId = parseInt(document.getElementById('id-hidden').textContent);
      if (userId == currentId) {
        let html = `<li class="my-message-list">` +
                        `<div class="my-message-main">` +
                          `<p class="my-message-time">${hours}:${minutes}</p>` +
                          `<p class="my-message-box">${data.content.content}</p>` +
                        `</div>` +
                      `</li>`;
        let messages = document.getElementById('open-message-lists');
        let newMessage = document.getElementById('open_message_content');
        messages.insertAdjacentHTML('beforeend', html);
        newMessage.value='';
        // メッセージ送信時、一番下にスクロールする
        $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });
      } else {
        let html = `<li class="message-list">` +
                      `<p class="message-user">${data.user.nickname}</p>` +
                      `<div class="message-main">` +
                        `<p class="message-box">${data.content.content}</p>` +
                        `<p class="message-time">${hours}:${minutes}</p>` +
                      `</div>` +
                    `</li>`;
        let messages = document.getElementById('open-message-lists');
        let newMessage = document.getElementById('open_message_content');
        const chatHeight = $('#inner-scroll').innerHeight();
        messages.insertAdjacentHTML('beforeend', html);
        newMessage.value='';
        // 他のメンバーのメッセージ送信時、スクロールが一番下であれば一番下にスクロールする
        if (chatHeight == $('#scroll').scrollTop() + $('#scroll').innerHeight() - 30) {
          $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });
        }
      }
    }
  }
});