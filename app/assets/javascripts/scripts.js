
$(function(){
    var breakpoints = {
            mobile: 500,
            tablet: 590,
            desktop: 800
        },
        bg_img = $('#bg'),
        bg_src_mobile = '/images/mobile-bg.jpg',
        bg_src_desktop = '/images/bg.jpg';

    resize_images();


    if ($('.panel select').length) {
        $('.panel select').dropkick();
    }


    if ($('#model_search select').length) {
        $('#model_search select').dropkick({
            change: function (value, label) {
                                window.location = $(".model-thumb[name*='" + $(this).find('option:selected').val() + "']").attr('href');
                            }
        });
    }

    $('.dk_options_inner').mCustomScrollbar({ scrollInertia: 0 })

    // resize background on load
    bg_img.load(function(){
        resizeBg();
    });

    // resize if window is changed
    $(window).resize(function(){
        resizeBg();
        resize_images();
    });

    $('.adminpanel .trigger').click(function(){
        $('.adminpanel').toggleClass('open');
    });

    $('.real-file-field').change(function(){
        $(this).siblings('.fake-file-field').attr('value',$(this).attr('value'));
    });

    $('#splash').click(function(){
        $(this).fadeOut();
    });

    function resizeBg() {
        bg_img.removeClass('bgheight bgwidth')
        if ($(window).width() < breakpoints.tablet) {
            bg_img.attr('src', bg_src_mobile);
        } else {
            bg_img.attr('src', bg_src_desktop);
            var aspectRatio = bg_img.width() / bg_img.height();
            if ( ($(window).width() / $(window).height()) <= aspectRatio ) {
                bg_img.addClass('bgheight');
            } else {
                bg_img.addClass('bgwidth');
            }
        }
    }
    
    function resize_images() {
        var w = Math.floor($('a.model-thumb').width());
        $('a.model-thumb').each(function(){
            $(this).height(w);
        });
    }
   
    if ($(window).width() >= breakpoints.tablet){
        var mag = $('#magazine');
        if (mag.length != 0) {
        
            // force the 3/4 aspect ratio
            var aspect_ratio = 3/4;

            mag.find('img').first().load( function(){
                // set height of magazine based on aspect ratio
                mag.height( mag.width()/(2*aspect_ratio) );
                mag.turn();
                // after initializing show
                mag.fadeTo(500,1);
            } );

            // center vertically
            // mag.css('top', ($(window).height()-mag.height() - 70 )/2);
            
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

            $(window).bind('keydown', function(e){
                // listen for arrow keys
                if (e.keyCode == 37){
                    mag.turn('previous');
                }
                else if (e.keyCode==39){
                    mag.turn('next');
                }
            });

        }
    }
});