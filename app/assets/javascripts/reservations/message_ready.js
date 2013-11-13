$(document).ready(function(){

  $(".table-body").on("click", "div.message-ready", function(){
    var reservationId = $(this).closest(".reservation").data("id")
    var boundMessageGuestReady = message.GuestReady.bind(this)
    boundMessageGuestReady(reservationId)
  })

})

var message = {
GuestReady: function(reservationId){
  var that = this
  $.ajax({
    url: "/messages",
    type: "post",
    data: {id: reservationId},
    data_type: "json"

  }).done(function(){
    $(that).removeClass("message-ready")
    $(that).html("sent")
    $(that).addClass("ready-message-sent")
    $("error-message").empty()
  }).error(function(){
    $("error-message").text("SMS failed :(")
  })
}
}

