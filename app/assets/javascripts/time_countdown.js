// function updateWaitTime() {
//   var restaurantId = $(".table").data("restaurant-id")
//   $.ajax({
//     url: "/reservations/updatetime",
//     type: 'post',
//     dataType: "json",
//     data: { restaurant_id: restaurantId }
//   }).done(function(waitTimes){
//     console.log(waitTimes);
//     var total = waitTimes.total;
//     for (var i = 1; i <= total; i++) {
//       var $thisRes = $(".reservation:nth-child("+i+")");
//       var id = $thisRes.data("id");
//       var minutesToWait = waitTimes[id].minutes;
//       $thisRes.find("span.wait-time").html(minutesToWait);
//     }
//   })
// };

// $(document).ready(function(){
//   if($(".reservation").length > 0) {
//     setInterval(function(){
//       updateWaitTime();
//     }, 60000);
//   }
// });
var timeStuff = []
updateWaitTime = function(){
  var reservations_on_page = $('.reservation')
  var timeREGEXP = /(\d+):(\d+)(pm|am)/
  var pmREGEXP = /pm/
  var currentTime = new Date(Date.now())
  var currentYear = currentTime.getFullYear()
  var currentMonth = currentTime.getMonth()
  var currentDate = currentTime.getDate()
  console.log(currentYear, currentMonth, currentDate)

  for(var i=0;i<reservations_on_page.length;i++){
    currentEstimatedTime = {}
    currentEstimatedTime.hour = (timeREGEXP.exec(($(reservations_on_page[i]).find('.seat-time')).text())[1])
    currentEstimatedTime.minute = (timeREGEXP.exec(($(reservations_on_page[i]).find('.seat-time')).text())[2])
    currentEstimatedTime.ampm = (timeREGEXP.exec(($(reservations_on_page[i]).find('.seat-time')).text())[3])
    if (pmREGEXP.exec(currentEstimatedTime.ampm) && currentEstimatedTime.hour != "12"){
      currentEstimatedTime.hour =  (parseInt(currentEstimatedTime.hour) + 12).toString()
    }
    console.log(currentEstimatedTime)
    var newTime = new Date(currentYear,currentMonth,currentDate,currentEstimatedTime.hour,currentEstimatedTime.minute)
    console.log("wait time: ",Math.round((newTime - Date.now())/60000))
    var newWaitTime  = Math.round((newTime - Date.now())/60000)
    $($(reservations_on_page[i]).find('.wait-time')).html(newWaitTime)   
}
}
