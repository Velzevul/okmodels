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

  $("#model_search select").click(function(){ 
    window.location = $(".model-thumb[name*='" + $(this).find('option:selected').val() + "']").attr('href');
  });

  $('.adminpanel .trigger').click(function(){
      $('.adminpanel').toggleClass('open');
  });

  $('.real-file-field').change(function(){
    $(this).siblings('.fake-file-field').attr('value',$(this).attr('value'));
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
  //var w = Math.floor((parent.width()-24)/6);
  var w = Math.floor((parent.width()-100)/5);
  $('a.model-thumb').each(function(){
    $(this).width(w);
    $(this).height(w);
  });
}

$(function(){
  var mag = $('#magazine');
  if (mag.length != 0) {
    // force the 3/4 aspect ratio
    var aspect_ratio = 3/4;
    mag.height(mag.width()/(2*aspect_ratio));
    // center vertically
    mag.css('top', ($(window).height()-mag.height() - 72 )/2);
    // initiazlie turn.js on the #magazine div
    mag.turn();
    // turn.js defines its own events. We are listening
    // for the turned event so we can center the magazine
    mag.bind('turn', function(e, page, pageObj) {
      if(page == 1 && $(this).data('done')){
        mag.addClass('centerStart');
      }
      else {
        mag.removeClass('centerStart');
      }
    });

    setTimeout(function(){
      // Leave some time for the plugin to
      // initialize, then show the magazine
      mag.fadeTo(500,1);
    },1000);

    $(window).bind('keydown', function(e){
      // listen for arrow keys
      if (e.keyCode == 37){
        mag.turn('previous');
      }
      else if (e.keyCode==39){
        mag.turn('next');
      }
    });

    mag.append('<div class="prev"></div>');
    mag.append('<div class="next"></div>');

    $('.next').click(function(){
      mag.turn('next');
    });

    $('.prev').click(function(){
      mag.turn('previous');
    });
  }
});