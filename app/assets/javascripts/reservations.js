var update = {

  init: function() {
    // $(this).removeClass("update-button")
    // $(this).addClass("save-button")
    $(this).closest(".table").find(".update-button").html("")

    var reservation = $(this).closest(".reservation");
    var id = reservation.data("id");

    update.partySize(reservation);
    update.guestName(reservation);
    update.phoneNumber(reservation);
    update.waitTime(reservation);

    $("form.reservation").undelegate(".update-button", "click");
    $(this).html('<input class="save-button" name="commit" type="submit" value="save">');
    $("form.reservation").on("click", ".save-button", update.save);
  },

  partySize: function(reservation) {
    var element = reservation.find(".party-size");
    var text = element.text();
    element.html('<input class="update update-party-size" name="reservation[party_size]" value="'+text+'">');
  },

  guestName: function(reservation) {
    var element = reservation.find(".name");
    var text = element.text();
    element.html('<input class="update update-name" name="reservation[name]" value="'+text+'">');
  },

  phoneNumber: function(reservation) {
    var element = reservation.find(".phone-number");
    var text = element.text();
    element.html('<input class="update update-phone-number" name="reservation[phone_number]" value="'+text+'">');
  },

  waitTime: function(reservation) {
    var element = reservation.find(".wait-time");
    var text = element.text();
    element.html('<input class="update update-wait-time" name="reservation[wait_time]" value="'+text+'">');
  },

  save: function(e) {
    e.preventDefault();
    var id = $(this).closest(".reservation").data("id").toString();
    var restaurant_id = $(this).closest(".reservation").data("restaurant-id").toString();
    var $that = $(this);

    $.ajax({
      url: "/restaurants/"+restaurant_id+"/reservations/"+id+"/",
      type: "put",
      dataType: "json",
      data: $(this).closest("form.reservation").serialize()
    }).done(function(data){
      $that.closest(".reservation").find("span.name").html(data.name);
      $that.closest(".reservation").find("span.party-size").html(data.party_size);
      $that.closest(".reservation").find("span.phone-number").html(data.phone_number);
      $that.closest(".reservation").find("span.wait-time").html(data.wait_time);
    })

    $("form.reservation").undelegate(".save-button", "click");
    // $(this).closest(".table").find(".update-button").html('<input type="submit" value="edit">')
    $("form.reservation").on("click", ".update-button", update.init);
  }
}

var reservationActions = {

  init: function() {
    $(".add_guest_form").on("ajax:success", "#new_reservation", this.addReservation);
    $(".add_guest_form").on("ajax:error", "#new_reservation", this.errorMessage);

    $("form.reservation").on("click", ".update-button", update.init);
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
