$(document).ready(function(){
  $("#main-nav").on("click", ".restaurant-name", showNav)
  $(".submit_button").prop("value", "+")
})

function showNav(e){
  e.preventDefault()
  if ($(".subnav").hasClass("hidden")) {
    $(".subnav").slideDown("slow")
    $(".subnav").removeClass("hidden")
  } else {
    $(".subnav").slideUp("slow")
    $(".subnav").addClass("hidden")
  }

}