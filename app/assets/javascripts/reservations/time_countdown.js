var UpdateReservations = {
  getReservationsFromServer: function(){
    var current_restaurant = $('div.table').data("restaurant-id")
    $.ajax({
      url: '/reservations/currentreservations.json',
      type: 'get',
      data: {current_restaurant: current_restaurant},
      dataType: 'json'
    }).done(function(reservations){
      UpdateReservations.addReservationsToPage(reservations)
    })
  },

  addReservationsToPage: function(reservations){
    $('div.table-body').empty()
    for(var i=0; i< reservations.reservations.length; i++){
      var updatedReservationTemplate = $('div#template > form').clone()
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
      updatedReservationTemplate.find('div.delete-button').html('<a href="/archive/'+reservations.reservations[i].restaurant_id+'/'+reservations.reservations[i].id+'" action="archive" class="delete" data-method="post" rel="nofollow">x</a>')
      $('div.table-body').append(updatedReservationTemplate)
    }
  }
}

var NoReservationsTimer = {
  updateCurrentTime: function(){
    //utilizes date.js formatting
    $('div#time').html(Date.now().toString("MMM d, yyyy h:mm tt"))
  },

  timeUpdateEveryMinute: function(){
    var boundUpdateCurrentTime = this.updateCurrentTime.bind(this)
    setInterval(function(){ boundUpdateCurrentTime() }, 1000)
  }
}

$(document).ready(function(){
  if($(".reservation").length) {
    NoReservationsTimer.timeUpdateEveryMinute()
    }
})

