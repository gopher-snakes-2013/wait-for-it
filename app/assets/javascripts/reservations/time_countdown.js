$(document).ready(function(){
  if($(".reservation").length > 0) {
    setInterval(function(){ updateReservations.updateCurrentTime()}, 60000)
    }})  

var updateReservations = {
getReservationsFromServer: function(){
  var current_restaurant = $('div.table').data("restaurant-id")
  $.ajax({
    url: '/reservations/currentreservations.json',
    type: 'get',
    data: {current_restaurant: current_restaurant},
    dataType: 'json'
  }).done(function(reservations){
    updateReservations.addReservationsToPage(reservations)
  })
},

addReservationsToPage: function(reservations){
  $('div.table-body').empty()
  for(var i=0; i< reservations.reservations.length; i++){
    var updatedReservationTemplate = $('div#template > form').clone()
    var statusId = updateStatusId(reservations.reservations[i]);

    $(updatedReservationTemplate).data("id", reservations.reservations[i].id)
    updatedReservationTemplate.find('span.name').html((reservations.reservations[i].name))
    updatedReservationTemplate.find('span.phone-number').html((reservations.reservations[i].phone_number))
    updatedReservationTemplate.find('span.status').html((reservations.reservations[i].status))

    updatedReservationTemplate.find('span.status').attr("id","status-"+reservations.reservations[i].status.toLowerCase())

    updatedReservationTemplate.find('span.party-size').html((reservations.reservations[i].party_size))
    updatedReservationTemplate.find('span.message-button').before('<span class="update-button"><input class="edit" type="submit" value="edit"></span>')
    updatedReservationTemplate.find('span.seat-time').html((reservations.reservations[i].estimated_seating))
    updatedReservationTemplate.find('span.wait-time').html((reservations.reservations[i].wait_time))
    if (reservations.reservations[i].notified){
      updatedReservationTemplate.find('span.message-button').html('<div class="ready-message-sent">sent</div><div class="delete-button"></div>')
    } else {
      updatedReservationTemplate.find('span.message-button').html('<div class="message-ready">notify</div><div class="delete-button"></div>')
    }
    updatedReservationTemplate.find('div.delete-button').html('<a href="/restaurants/'+reservations.reservations[i].restaurant_id+'/reservations/'+reservations.reservations[i].id+'" action="destroy" class="delete" data-method="delete" rel="nofollow">x</a>')
    $('div.table-body').append(updatedReservationTemplate)
  }
},

calculateCurrentTime: function(){
  var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
  var currentTime = new Date(Date.now())
  var currentMonth = months[currentTime.getMonth()]
  var currentDate = currentTime.getDate()
  var currentYear = currentTime.getFullYear() 
  var currentHour = currentTime.getHours()
  var currentMinutes = currentTime.getMinutes()
  if (currentMinutes.toString().length === 1){
    currentMinutes = "0"+currentMinutes
  }
  var currentAMPM = ""
  if(currentHour>=12){
    currentAMPM = "pm"
  } else {
    currentAMPM = "am"
  }
  if (currentHour > 12) {
    currentHour -= 12 
  }
  return currentMonth+ " "+currentDate+", "+currentYear+" "+currentHour+":"+currentMinutes+currentAMPM

},
updateCurrentTime: function(){
  $('div#time').html(this.calculateCurrentTime())
}
}

var updateStatusId = function(data) {
 console.log(data) 
 var statusText = data.status;
 if (statusText == 'Waiting') {
  var statusId = 'status-waiting';
  } else if (statusText == 'Cancelled') {
    statusId = 'status-cancelled';
  } else if (statusText == 'No-Show') {
    statusId = 'status-no-show';
  } else if (statusText == 'Seated') {
    statusId = 'status-seated';
  }
  return statusId;
}




