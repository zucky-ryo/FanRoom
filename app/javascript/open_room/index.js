$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/open_rooms/) && urlPath.match(/\d/) == null && urlPath.match(/new/) == null) {
    $('#header-open-room').css('background', 'yellow');

    // ルーム名検索（１文字打つたびに判定）
    const searchBox = $('#room-name-search');
    const roomBox = $('#room-lists')
    const roomName = $('.open-list-css');
    const nameArray = [];
    roomName.each((index, element) => {
      nameArray.push($(element).html());
    });
    searchBox.keyup(() => {
      const result = $.grep(nameArray, (value, index) => {
        const searchResult = value.indexOf(searchBox.val()) != -1;
        return searchResult;
      });
      roomBox.empty();
      $(result).each((index, element) => {
        roomBox.append(element);
      });
    });
  }
});