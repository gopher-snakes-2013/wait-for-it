$(document).ready(function(){
  $("#main-nav").mouseenter(showNav).mouseleave(hideNav);
  $(".submit_button").prop("value", "+")
})
// you're polluting the global namespace. namespace it using object literals/modules, etc.
function showNav(e){
  e.preventDefault()
    $(".subnav").slideDown("slow")
    $(".subnav").removeClass("hidden")
}
// you're polluting the global namespace. namespace it using object literals/modules, etc.
function hideNav(e){
    $(".subnav").slideUp("slow")
    $(".subnav").addClass("hidden")
}
