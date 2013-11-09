var update = {

  partySize: function() {
    var id = $(this).closest(".reservation").data("id");
    var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"></form>';
    var text = $(this).text();
    $(this).html(formTemplate);
    $(this).find("form").append('<input class="update update-party-size" name="reservation[party_size]" value="'+text+'">');
    $(".reservation").undelegate(".party-size", "click");
  },

  guestName: function() {
    var id = $(this).closest(".reservation").data("id");
    var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"></form>';
    var text = $(this).text();
    $(this).html(formTemplate);
    $(this).find("form").append('<input class="update update-name" name="reservation[name]" value="'+text+'">');
    $(".reservation").undelegate(".name", "click");
  },

  phoneNumber: function() {
    var id = $(this).closest(".reservation").data("id");
    var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"></form>';
    var text = $(this).text();
    $(this).html(formTemplate);
    $(this).find("form").append('<input class="update update-phone-number" name="reservation[phone_number]" value="'+text+'">');
    $(".reservation").undelegate(".phone-number", "click");
  },

  waitTime: function() {
    var id = $(this).closest(".reservation").data("id");
    var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"></form>';
    var text = $(this).text();
    $(this).html(formTemplate);
    $(this).find("form").append('<input class="update update-wait-time" name="reservation[wait_time]" value="'+text+'">');
    $(".reservation").undelegate(".wait-time", "click");
  }

}

var reservationActions = {

  init: function() {
    $(".add_guest_form").on("ajax:success", "#new_reservation", this.addReservation);
    $(".add_guest_form").on("ajax:error", "#new_reservation", this.errorMessage);

    $(".reservation").on("click", ".party-size", update.partySize);
    $(".reservation").on("click", ".name", update.guestName);
    $(".reservation").on("click", ".phone-number", update.phoneNumber);
    $(".reservation").on("click", ".wait-time", update.waitTime);

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

  showDelete: function() {
    $(this).find(".delete").removeClass("hidden");
  },

  hideDelete: function() {
    $(this).find(".delete").addClass("hidden");
  }
};

$(document).ready(function(){
  reservationActions.init();
});
