import consumer from "./consumer"

consumer.subscriptions.create("OpenMessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
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
      messages.insertAdjacentHTML('beforeend', html);
      newMessage.value='';
    }
  }
});