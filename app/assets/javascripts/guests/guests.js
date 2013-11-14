var GuestPage = {
  showLogin: function(){
    $(".guest-signin-form").slideToggle("slideDown")
  },

  showForm: function(){
    var restaurantId = $(this).closest(".restaurant").data("restaurant-id")
    var $requestForm = $(".request-form").clone()
    $requestForm = $requestForm.find("form").prop("action", "restaurants/"+restaurantId+"/reservations")
    $("#form_"+restaurantId).html($requestForm).slideToggle("slideDown")
  },

  sendRequest: function(e, data){
    $(".confirmation-text").html(data.text)
    GuestPage.clearFields();
  },

  showErrorMessage: function(e, xhr) {
    $(".confirmation-text").html(xhr.responseJSON.simple_error)
  },

  clearFields: function(){
    $("#request-name").val("")
    $("#request-party-size").val("")
    $("#request-phone-number").val("")
  },

  cancel: function(e){
    e.preventDefault();
    var restaurant_id = $(".guest-reservation").data("restaurant-id")
    var id = $(".guest-reservation").data("id")

    $.ajax({
      url: "/restaurants/"+restaurant_id+"/reservations/"+id,
      type: "put",
      dataType: "json",
      data: { restaurant_id: restaurant_id, id: id, reservation: { status: "Cancelled" } }
    }).done(function(data){
      console.log(data)
    }).fail(function(){
    })
  }

}

$(document).ready(function(){
  $("#container").on("click", "a.guest-sign-in", GuestPage.showLogin)
  $("#container").on("click", ".restaurant-request", GuestPage.showForm)
  $("#container").on("ajax:success", "form#new-request", GuestPage.sendRequest)
  $("#container").on("ajax:error", "form#new-request", GuestPage.showErrorMessage)

  $("#container").on("click", "span.guest-cancel", GuestPage.cancel)
})