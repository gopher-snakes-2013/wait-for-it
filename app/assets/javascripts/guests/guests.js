var GuestPage = {
  showLogin: function(){
    $(".guest-signin-form").slideToggle("slideDown")
  },

  showForm: function(){
    var restaurantId = $(this).closest(".restaurant").data("restaurant-id")
    var $requestForm = $(".request-form").clone()
    $requestForm = $requestForm.find("form").prop("action", "restaurants/"+restaurantId+"/reservations")
    $(".form-area").html($requestForm)
  },

  sendRequest: function(e, data){
    $(".confirmation-area").html(data.text)
  },

  showErrorMessage: function(e, xhr) {
    $(".confirmation-area").html(xhr.responseJSON.simple_error)
  }
}

$(document).ready(function(){
  $("body").on("click", "a.guest-sign-in", GuestPage.showLogin)
  $("body").on("click", ".restaurant-request", GuestPage.showForm)
  $("body").on("ajax:success", "form#new-request", GuestPage.sendRequest)
  $("body").on("ajax:error", "form#new-request", GuestPage.showErrorMessage)
})