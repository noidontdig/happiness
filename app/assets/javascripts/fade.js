$(document).ready(function(){
  function fadeContent() {
    $(".home_tweets .tweet:hidden:first").fadeIn(2000).delay(6000).fadeOut(2000, function() {
      $(this).appendTo($(this).parent());
      fadeContent();
    });
  }
  fadeContent();
});