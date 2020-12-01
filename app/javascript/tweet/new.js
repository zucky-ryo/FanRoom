$(function(){
  const urlPath = location.pathname;
  if (urlPath.match(/tweets/) && urlPath.match(/\d/) == null) {
    const imageList = $('#image-list');
    $('#tweet_image').change((e) => {
      if (imageList.find('img') || imageList.find('video')){
        imageList.empty();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      if (file.name.match(/.mp4/)){
        var blobImage = document.createElement('video');
      }else{
        var blobImage = document.createElement('img');
      }
      blobImage.setAttribute('src', blob);
      imageList.append(blobImage);
    });
  }
});