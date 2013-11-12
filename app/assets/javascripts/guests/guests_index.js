var restaurant = {

  toggleLogin: function(e) {
    e.preventDefault()
    if ( $(".restaurant-login").hasClass("hidden") ) {
      $(".restaurant-login").slideDown("slow")
      $(".restaurant-login").removeClass("hidden")
    } else {
      $(".restaurant-login").slideUp("slow")
      $(".restaurant-login").addClass("hidden")
    }
  },

  showRegister: function(e, registerPage) {
    $("#container").addClass("hidden").html(registerPage)
    $("#container").fadeIn()
  }
}

$(document).ready(function(){
  $(".body").on("click", ".restaurant-button", restaurant.toggleLogin)
  $(document).on("ajax:success", ".register-link", restaurant.showRegister)
})