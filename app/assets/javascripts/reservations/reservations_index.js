$(document).ready(function(){
  $("#main-nav").mouseenter(showNav).mouseleave(hideNav);
  $(".submit_button").prop("value", "+")
})

function showNav(e){
  e.preventDefault()
    $(".subnav").slideDown("slow")
    $(".subnav").removeClass("hidden")
}

function hideNav(e){
    $(".subnav").slideUp("slow")
    $(".subnav").addClass("hidden")
}