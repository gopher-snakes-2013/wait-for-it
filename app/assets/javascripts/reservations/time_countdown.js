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