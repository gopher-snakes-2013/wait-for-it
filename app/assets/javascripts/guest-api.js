$(document).ready(function(){
if($('#guest-container').length > 0){
  getReservations.callServer()
}
})


var waitlist = {

  addWaitlist: function(){
    $('#guest-container').removeClass("hidden")
  },

  addGuest: function(guest){
    console.log(guest)
    // var name = that.name
    var guest_row = "<tr class='reservation'><td><span<span class='name'>"+guest.initial
    +"</span></td><td><span class='party-size'>"+guest.party_size
    +"</span></td><td><span class='phone-number'>"+guest.phone_number
    +"</span></td><td><span class='wait-time'>"+guest.estimated_seating+"</span></td>"
    console.log(guest_row)
    $('#wait-list-guest > tbody.guests').append(guest_row)
  }




}
var getReservations = {  

    callServer: function(){

    var restaurantName = $(location).attr('pathname').slice(7)
      $.ajax({
    url: '/reservations/'+restaurantName+'/list.json',
    type: 'get'

  }).done(function(data){
    console.log(data)
    waitlist.addWaitlist()
    for(var i=0;i<data.reservations.length;i++){
      waitlist.addGuest(data.reservations[i])
    }
  })
}
}