var GuestPage = {
  showLogin: function(){
    $(".guest-signin-form").slideToggle("slideDown")
  },

  showAllRestaurants: function(){

  }
}

$(document).ready(function(){
  $("body").on("click", "a.guest-sign-in", GuestPage.showLogin)
  $(document).on("ajax:success", ".submit", GuestPage.showAllRestaurants)
})