$(document).ready(function(){
  resize_images();

  // resize background on load
  $('#bg').load(function(){
    resizeBg();
  });

  // resize if window is changed
  $(window).resize(function(){
    resizeBg();
    resize_images();
  });

  $("#model_search select").change(function(){ 
    $("#model_search input[type='submit']").trigger('click');
  });

  $('.adminpanel .trigger').click(function(){
      $('.adminpanel').toggleClass('open');
  });

});

function resizeBg() {
  var bgimg = $('#bg');
  var aspectRatio = bgimg.width() / bgimg.height();
  bgimg.removeClass('bgheight bgwidth')
  if ( ($(window).width() / $(window).height()) <= aspectRatio ) {
    bgimg.addClass('bgheight');
  } else {
    bgimg.addClass('bgwidth');
  }
};

function resize_images() {
  var parent = $('.content');
  var w = Math.floor((parent.width()-24)/6);
  $('a.model-thumb').each(function(){
    $(this).width(w);
    $(this).height(w);
  });
}