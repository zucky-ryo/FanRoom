// チームタグを複数つける場合にセレクトボックスを追加する（６個まで）
$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/open_rooms/)) {
    const selectBox = $('#open-team-select').html();
    let count = 0
    $('#add-open-tag').click(() => {
      if (count < 5) {
        $('#open-team-select').append(selectBox);
        count += 1
      }
    });
  }
});