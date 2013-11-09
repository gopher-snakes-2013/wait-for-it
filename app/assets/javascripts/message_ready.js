$(document).ready(function(){

  $('.rezzy').on("click",".message-ready", function(){
    // event.preventDefault();
    var guest_id = $(this).closest('tr').data("id")
    console.log("event listener for message ready called", $(this).closest('tr').data("id"))
    var bound_message_guest_ready = message_guest_ready.bind(this)
    bound_message_guest_ready(guest_id);
  })


})


var message_guest_ready = function(guest_id){
  var that = this
  $.ajax({
    url: '/messages',
    type: 'post',
    data: {guest_id: guest_id},
    data_type: 'json'

  }).done(function(){
    $(that).removeClass("message-ready")
    $(that).addClass("ready-message-sent")
    $('error-message').empty()
  }).error(function(){
    $('error-message').text("SMS failed :(")
  })
}