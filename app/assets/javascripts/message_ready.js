$(document).ready(function(){

  $('.rezzy').on("click",".message-ready", function(){
    // event.preventDefault();
    var guest_id = $(this).closest('tr').data("id")
    console.log("event listener for message ready called", $(this).closest('tr').data("id"))
    message_guest_ready(guest_id);
  })


})


var message_guest_ready = function(guest_id){
  $.ajax({
    url: '/messages',
    type: 'post',
    data: {guest_id: guest_id},
    data_type: 'json'

  }).done(function(response){
    console.log(response)
  }).error(function(response){
    console.log(response)
  })
}