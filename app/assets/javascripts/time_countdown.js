function updateWaitTime() {
  var restaurantId = $(".table").data("restaurant-id")
  $.ajax({
    url: "/reservations/updatetime",
    type: 'post',
    dataType: "json",
    data: { restaurant_id: restaurantId }
  }).done(function(waitTimes){
    console.log(waitTimes);
    var total = waitTimes.total;
    for (var i = 1; i <= total; i++) {
      var $thisRes = $(".reservation:nth-child("+i+")");
      var id = $thisRes.data("id");
      var minutesToWait = waitTimes[id].minutes;
      $thisRes.find("span.wait-time").html(minutesToWait);
    }
  })
};

$(document).ready(function(){
  if($(".reservation").length > 0) {
    setInterval(function(){
      updateWaitTime();
    }, 60000);
  }
});
