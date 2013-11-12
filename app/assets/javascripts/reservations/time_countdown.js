$(document).ready(function(){
  if($(".reservation").length > 0) {
    setInterval(function(){
      updateReservations.updateWaitTime();
      updateReservations.getEstimatedSeatTimesFromServer()
      updateReservations.updateCurrentTime()
    }, 60000)
    }})
  
var updateReservations = {
updateWaitTime: function(){
  var reservations_on_page = $('.reservation')
  var timeREGEXP = /(\d+):(\d+)(pm|am)/
  var pmREGEXP = /pm/
  var currentTime = new Date(Date.now())
  var currentYear = currentTime.getFullYear()
  var currentMonth = currentTime.getMonth()
  var currentDate = currentTime.getDate()

  for(var i=0;i<reservations_on_page.length;i++){
    currentEstimatedTime = {}
    currentEstimatedTime.hour = (timeREGEXP.exec(($(reservations_on_page[i]).find('.seat-time')).text())[1])
    currentEstimatedTime.minute = (timeREGEXP.exec(($(reservations_on_page[i]).find('.seat-time')).text())[2])
    currentEstimatedTime.ampm = (timeREGEXP.exec(($(reservations_on_page[i]).find('.seat-time')).text())[3])
    if (pmREGEXP.exec(currentEstimatedTime.ampm) && currentEstimatedTime.hour != "12"){
      currentEstimatedTime.hour =  (parseInt(currentEstimatedTime.hour) + 12).toString()
    }
    var newTime = new Date(currentYear,currentMonth,currentDate,currentEstimatedTime.hour,currentEstimatedTime.minute)
    var newWaitTime  = Math.round((newTime - Date.now())/60000)
    $($(reservations_on_page[i]).find('.wait-time')).html(newWaitTime)   
}
},

getReservationsOnPage: function(){
  var reservation = { reservations_on_page:[]}
  $reservations = $('.reservation')
  for(var i=0; i< $reservations.length; i++){
    reservation.reservations_on_page.push($($reservations[i]).data("id"))
  }
  return reservation;
},

getEstimatedSeatTimesFromServer: function(){
  var reservations_on_page = this.getReservationsOnPage()
  $.ajax({
    url: '/reservations/seattimes',
    type: 'get',
    data: reservations_on_page
  }).done(function(currentEstimatedSeatTimes){ 
    $reservations = $('.reservation')
    for(var i=0; i< $reservations.length; i++){
    if(($($reservations[i]).data("id")) in currentEstimatedSeatTimes.estimated_seat_times){
      $($reservations[i]).find('.seat-time').text(currentEstimatedSeatTimes.estimated_seat_times[$($reservations[i]).data("id")].seat_time)
      $($reservations[i]).find('.status').text(currentEstimatedSeatTimes.estimated_seat_times[$($reservations[i]).data("id")].status)
    }
  }
  })
},

calculateCurrentTime: function(){
  var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
  var currentTime = new Date(Date.now())
  var currentMonth = months[currentTime.getMonth()]
  var currentDate = currentTime.getDate()
  var currentYear = currentTime.getFullYear() 
  var currentHour = currentTime.getHours()
  var currentMinutes = currentTime.getMinutes()
  if (currentMinutes.length === 1){
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