$(document).ready(function(){
  function fadeContent() {
    $(".tweets .tweet:hidden:first").fadeIn(500).delay(2000).fadeOut(500, function() {
      $(this).appendTo($(this).parent());
      fadeContent();
    });
  }
  fadeContent();
});