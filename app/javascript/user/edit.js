$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/users/)) {
    const detail = document.getElementById('edit-detail');
    $('#detail-btn').click(() => {
      if (detail.hasChildNodes()) {
        $('#edit-detail').empty();
      }else{
        $('#edit-detail').html(
          '<div class="form-group">' +
            '<div class="form-text-wrap">' +
              '<label class="form-text">メールアドレス</label>' +
              '<span class="indispensable">必須</span>' +
            '</div>' +
            '<input class="input-default" id="email" placeholder="PC・携帯どちらでも可" type="email" name="user[email]">' +
          '</div>' +
          '<div class="form-group">' +
            '<div class="form-text-wrap">' +
              '<label class="form-text">パスワード</label>' +
              '<span class="indispensable">必須</span>' +
            '</div>' +
            '<input class="input-default" id="password" placeholder="6文字以上の半角英数字" autocomplete="new-password" type="password" name="user[password]">' +
            '<p class="info-text">※英字と数字の両方を含めて設定してください</p>' +
          '</div>' +
          '<div class="form-group">' +
            '<div class="form-text-wrap">' +
              '<label class="form-text">パスワード(確認)</label>' +
              '<span class="indispensable">必須</span>' +
            '</div>' +
            '<input class="input-default" id="password-confirmation" placeholder="同じパスワードを入力してください" autocomplete="new-password" type="password" name="user[password_confirmation]">' +
          '</div>' +
          '<div class="form-group">' +
            '<div class="form-text-wrap">' +
              '<label class="form-text">現在のパスワード</label>' +
              '<span class="indispensable">必須</span>' +
            '</div>' +
            '<input class="input-default" id="current-password" placeholder="現在のパスワードを入力してください" autocomplete="current-password" type="password" name="user[current_password]">' +
          '</div>'
        );
      }
    });
  }
});