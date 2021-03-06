import consumer from "./consumer"

consumer.subscriptions.create("PrivateMessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const urlPath = location.pathname;
    if (urlPath == '/private_rooms/' + data.content.private_room_id.toString()) {
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
        let messages = document.getElementById('private-message-lists');
        let newMessage = document.getElementById('private_message_content');
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
        let messages = document.getElementById('private-message-lists');
        const chatHeight = $('#inner-scroll').innerHeight();
        messages.insertAdjacentHTML('beforeend', html);
        // 他のメンバーのメッセージ送信時、スクロールが一番下であれば一番下にスクロールする
        if (chatHeight == $('#scroll').scrollTop() + $('#scroll').innerHeight() - 30) {
          $('#scroll').prop({ scrollTop: $("#scroll").prop("scrollHeight") });
        }
      }
    }
  }
});
