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
    interval = setInterval(function(){ timeToWait.countdown() }, 60000);
  }
};

$(document).ready(function(){
  timeToWait.init();
});
