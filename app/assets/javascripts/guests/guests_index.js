var Restaurant = {

  toggleLogin: function(e) {
    e.preventDefault()
    $(".restaurant-login").toggle('hidden');
    $(".restaurant-login").toggleSlide();
  },

  showRegister: function(e, registerPage) {
    // no reason to use #container, add another div to the DOM and just slide it without toggling hidden.
    $("#container").addClass("hidden").html(registerPage)
    $("#container").slideDown()
  }
}

var Guest = {

  showAllRestaurants: function(e, restaurantPage) {
    // no reason to use #container, add another div to the DOM and just slide it without toggling hidden.
    $("#container").addClass("hidden").html(restaurantPage);
    $("#container").slideDown("slow");
  }
}

$(document).ready(function(){
  // .body is a bad className it could get confused with body tag.
  $(".body").on("click", ".restaurant-link", Restaurant.toggleLogin)
  $(document).on("ajax:success", ".guest-link", Guest.showAllRestaurants )
  $(document).on("ajax:success", ".register-link", Restaurant.showRegister)
})
