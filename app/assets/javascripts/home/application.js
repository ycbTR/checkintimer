// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function () {

    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('.scrollup').fadeIn();
        } else {
            $('.scrollup').fadeOut();
        }
    });

    $('.scrollup').click(function () {
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });

});
$(document).ready(function () {
    $('#countdown_dashboard').countDown({
        targetDate: {
            'day': 01,
            'month': 12,
            'year': 2013,
            'hour': 12,
            'min': 00,
            'sec': 0
        },
        // onComplete function
        onComplete: function () {
            $('#main-text').replaceWith('<h2 class="#main-text">WE ARE FINISHED!</h2>');
            $('#second-text').replaceWith('<h3 class="#second-text">Please wait while we finish updating the site.</h3>');
        }

    });

    $("#Gmap").gmap3({
            map: {
                options: {
                    maxZoom: 16,
                    zoomControl: false,
                    streetViewControl: false
                }
            },
            marker: {
                address: "Papine Square, Kingston, Jamaica",    //Paste address here
                options: {
                    icon: new google.maps.MarkerImage(
                        "/assets/marker.png",
                        new google.maps.Size(32, 46, "px", "px")
                    )
                }
            }
        },
        "autofit");
});


