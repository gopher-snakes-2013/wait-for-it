var reservationActions = {
  init: function() {
    $("#new_reservation").on("ajax:success", this.addReservation);
    $("#new_reservation").on("ajax:error", this.errorMessage);

    $(".party-size").on("click", this.update);
    $(".rezzy").on("mouseenter", this.showDelete);
    $(".rezzy").on("mouseleave", this.hideDelete);
  },

  addReservation: function(e, reservationPartial) {
    $(".reservation-list").append(reservationPartial);

    $("#reservation_name").val("");
    $("#reservation_party_size").val("");
    $("#reservation_phone_number").val("");
    $("#reservation_wait_time").val("");
  },

  errorMessage: function(e, xhr) {
    var error = xhr.responseJSON.error_message;
    $(".error-message").html(error);
  },

  update: function() {
    var id = $(this).data("id");
    var text = $(this).text();
    var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"><input class="updated-party-size" name="reservation[party_size]" value="'+text+'"></form>';
    $(this).html(formTemplate);
    $(".party-size").unbind();
  },

  showDelete: function() {
    $(this).find(".delete").removeClass("hidden");
  },

  hideDelete: function() {
    $(this).find(".delete").addClass("hidden");
  }
};

var timeToWait = {

  init: function() {
    $(".submit_button").on("click", this.startInterval);
  },

  countdown: function() {
    if (waitTime > 1) {
      waitTime = waitTime -1;
      $(".rezzy").last().find(".wait-time").html(waitTime);
    } else {
      clearInterval(interval);
      $(".rezzy").last().find(".times-up").html("done");
    }
  },

  startInterval: function() {
    waitTime = $("#reservation_wait_time").val();
    $(".wait-time").html(waitTime);

    interval = setInterval(function(){ timeToWait.countdown() }, 60000);
  }

    // want to get the wait time... $("#reservation_wait_time").val()
    // initialize countdown and have it update the wait time on the screen

    // how to tie into the database...
    // get a json object from ajax that poops the reservation on the screen without reload,
    // tie in the javascript function to the wait_time held in the database?
    // have it update on the screen?
};

$(document).ready(function(){
  reservationActions.init();
  timeToWait.init();
});
