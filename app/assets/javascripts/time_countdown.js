var timeToWait = {

  init: function() {
    $(".submit_button").on("click", this.startInterval);
  },

  countdown: function() {
    if (waitTime > 0) {
      waitTime = waitTime -1;
      $(".reservation").last().find(".wait-time").html(waitTime);
    } else {
      clearInterval(interval);
    }
  },

  getWaitTime: function() {
    var waitTime = $("#reservation_wait_time").val();
    return waitTime;
  },

  startInterval: function() {
    waitTime = timeToWait.getWaitTime();
    interval = setInterval(function(){
      timeToWait.countdown()
    }, 1000);
  }
};

$(document).ready(function(){
  setInterval(function(){
    updateWaitTime();
  }, 60000);
});

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
      var $thisRes = $("form.reservation:nth-child("+i+")");
      var id = $thisRes.data("id");
      var minutesToWait = waitTimes[id].minutes;
      $thisRes.find("span.wait-time").html(minutesToWait);
    }
  })
};