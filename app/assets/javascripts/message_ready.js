$(document).ready(function(){

  $("span.message-button").on("click", "button.message-ready", function(){
    var guestId = $(this).closest(".reservation").data("id")
    var boundMessageGuestReady = messageGuestReady.bind(this)
    boundMessageGuestReady(guestId)
  })

})

var messageGuestReady = function(guest_id){
  var that = this
  $.ajax({
    url: "/messages",
    type: "post",
    data: {guest_id: guest_id},
    data_type: "json"

  }).done(function(){
    $(that).removeClass("message-ready")
    $(that).addClass("ready-message-sent")
    $("error-message").empty()
  }).error(function(){
    $("error-message").text("SMS failed :(")
  })
}
