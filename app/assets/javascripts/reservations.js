var reservationActions = {
  init: function() {
    $(".add_guest_form").on("ajax:success", "#new_reservation", this.addReservation);
    $(".add_guest_form").on("ajax:error", "#new_reservation", this.errorMessage);

    $(".reservation").on("click", ".party-size", this.update);
    $(".table").on("mouseenter", ".reservation", this.showDelete);
    $(".table").on("mouseleave", ".reservation", this.hideDelete);
  },

  addReservation: function(e, reservationPartial) {
    $("table").append(reservationPartial);

    $("#reservation_name").val("");
    $("#reservation_party_size").val("");
    $("#reservation_phone_number").val("");
    $("#reservation_wait_time").val("");
    $(".error-message").html("");
  },

  errorMessage: function(e, xhr) {
    var error = xhr.responseJSON.error_message;
    $(".error-message").html(error);
  },

  update: function() {
    var id = $(this).closest(".reservation").data("id")
    var text = $(this).text();
    var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"><input class="updated-party-size" name="reservation[party_size]" value="'+text+'"></form>';
    $(this).html(formTemplate);
    $(".reservation").undelegate(".party-size", "click");
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
      $(".reservation").last().find(".wait-time").html(waitTime);
    } else {
      waitTime = waitTime -1;
      $(".reservation").last().find(".wait-time").html(waitTime);
      clearInterval(interval);
      $(".reservation").last().find(".times-up").html("x");
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
  reservationActions.init();
  timeToWait.init();
});
