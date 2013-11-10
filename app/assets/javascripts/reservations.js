var update = {

  init: function() {
    var reservation = $(this).closest(".reservation");
    var id = reservation.data("id");

    update.partySize(reservation);
    update.guestName(reservation);
    update.phoneNumber(reservation);
    update.waitTime(reservation);

    $(this).html('<input name="commit" type="submit" value="save">');
  },

  partySize: function(reservation) {
    var element = reservation.find(".party-size");
    var text = element.text();
    element.html('<input class="update update-party-size" name="reservation[party_size]" value="'+text+'">');
    $(".reservation").undelegate(".update-button", "click");
  },

  guestName: function(reservation) {
    var element = reservation.find(".name");
    var text = element.text();
    element.html('<input class="update update-name" name="reservation[name]" value="'+text+'">');
    $(".reservation").undelegate(".update-button", "click");
  },

  phoneNumber: function(reservation) {
    var element = reservation.find(".phone-number");
    var text = element.text();
    element.html('<input class="update update-phone-number" name="reservation[phone_number]" value="'+text+'">');
    $(".reservation").undelegate(".update-button", "click");
  },

  waitTime: function(reservation) {
    var element = reservation.find(".wait-time");
    var text = element.text();
    element.html('<input class="update update-wait-time" name="reservation[wait_time]" value="'+text+'">');
    $(".reservation").undelegate(".update-button", "click");
  }

}

var reservationActions = {

  init: function() {
    $(".add_guest_form").on("ajax:success", "#new_reservation", this.addReservation);
    $(".add_guest_form").on("ajax:error", "#new_reservation", this.errorMessage);

    $(".reservation").on("click", ".update-button", update.init);
  },

  addReservation: function(e, reservationPartial) {
    $(".table-body").append(reservationPartial);

    $("#reservation_name").val("");
    $("#reservation_party_size").val("");
    $("#reservation_phone_number").val("");
    $("#reservation_wait_time").val("");
    $(".error-message").html("");
  },

  errorMessage: function(e, xhr) {
    var error = xhr.responseJSON.error_message;
    $(".error-message").html(error);
  }
};

$(document).ready(function(){
  reservationActions.init();
});
