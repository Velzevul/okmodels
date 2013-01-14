var bgimg = $('#bg');

$(document).ready(function(){

  // TODO: remove later
  // $.get('main.html', function(data) {
  //   $('.content').html(data);
  // }); 

  // resize background on load
  bgimg.load(function(){
    resizeBg();
  });

  // resize if window is changed
  $(window).resize(function(){
    resizeBg();
  });

});


function resizeBg() {
  var aspectRatio = bgimg.width() / bgimg.height();
  bgimg.removeClass('bgheight bgwidth')
  if ( ($(window).width() / $(window).height()) <= aspectRatio ) {
    bgimg.addClass('bgheight');
  } else {
    bgimg.addClass('bgwidth');
  }
};
