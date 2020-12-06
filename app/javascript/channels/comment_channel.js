import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const urlPath = location.pathname;
    if (urlPath == '/tweets/' + data.content.tweet_id.toString()) {
      const japanStandardTime = new Date().toLocaleString({ timeZone: 'Asia/Tokyo' });
      const hours = new Date(japanStandardTime).getHours();
      const minutes = new Date(japanStandardTime).getMinutes().toString().padStart(2, '0');
      const html =  `<li class="tweet-comment-list">` +
                      `<div class="tweet-comment-top">` +
                        `<p class="tweet-comment-user">${data.user.nickname}</p>` +
                        `<p class="tweet-comment-date">Today ${hours}:${minutes}</p>` +
                      `</div>` +
                      `<div class="tweet-comment-main">` +
                        `<p class="tweet-comment-content">${data.content.content}</p>` +
                      `</div>` +
                    `</li>`;
      const messages = document.getElementById('tweet-comments');
      const newMessage = document.getElementById('comment_content');
      messages.insertAdjacentHTML('afterbegin', html);
      newMessage.value='';
    }
  }
});
