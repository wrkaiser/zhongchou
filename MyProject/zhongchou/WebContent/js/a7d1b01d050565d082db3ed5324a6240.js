$(function(){
    $(".m-deputy-left ").hover(function() {
        $(this).children(".ul-slide").stop().slideDown('fast');
    }, function() {
        $(this).children(".ul-slide").stop().slideUp("fast");
    });
});
