var Restaurant = {

  toggleLogin: function(e) {
    e.preventDefault()
    if ( $(".restaurant-login").hasClass("hidden") ) {
      $(".restaurant-login").slideDown()
      $(".restaurant-login").removeClass("hidden")
      $(".error").addClass("hidden")
    } else {
      $(".restaurant-login").slideUp()
      $(".restaurant-login").addClass("hidden")
    }
  },

  showRegister: function(e, registerPage) {
    $("#container").addClass("hidden").html(registerPage)
    $("#container").slideDown()
  }
}

var Guest = {

  showAllRestaurants: function(e, restaurantPage) {
    $("#container").addClass("hidden").html(restaurantPage);
    $("#container").slideDown("slow");
  }
}

$(document).ready(function(){
  $(".body").on("click", ".restaurant-link", Restaurant.toggleLogin)
  $(document).on("ajax:success", ".guest-link", Guest.showAllRestaurants )
  $(document).on("ajax:success", ".register-link", Restaurant.showRegister)
})
