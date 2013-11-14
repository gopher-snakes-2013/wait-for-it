// this polutes the global namespace, either move to update object or create a new Timer object.
var superBadAssTimer;
// please upcase your object
var update = {

  init: function(el) {
    var $edit = $(el);
    var reservation = $edit.closest(".reservation");
    var id = reservation.data("id");
    this.partySize(reservation);
    this.guestName(reservation);
    this.phoneNumber(reservation);
    this.waitTime(reservation);
    this.status(reservation);
    clearInterval(superBadAssTimer)
    $edit.closest(".update-button").html('<input class="save" name="commit" type="submit" value="save">');
    $(".edit").remove();
  },

  partySize: function(reservation) {
    var element = reservation.find(".party-size");
    var text = element.text();
    // put the select box under a hidden templates div, select it, clone it, modify and then inject in the DOM
    element.html('<select class="update update-party-size" name="reservation[party_size]"><option value="'+text+'" selected>'+text+'</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option></select>');
  },

  guestName: function(reservation) {
    var element = reservation.find(".name");
    var text = element.text();
    // put the select box under a hidden templates div, select it, clone it, modify and then inject in the DOM
    element.html('<input class="update update-name" name="reservation[name]" value="'+text+'">');
  },

  phoneNumber: function(reservation) {
    var element = reservation.find(".phone-number");
    var text = element.text();
    // put the select box under a hidden templates div, select it, clone it, modify and then inject in the DOM
    element.html('<input class="update update-phone-number" name="reservation[phone_number]" value="'+text+'">');
  },

  waitTime: function(reservation) {
    var element = reservation.find(".wait-time");
    var text = element.text();
    // put the select box under a hidden templates div, select it, clone it, modify and then inject in the DOM
    element.html('<select class="update update-wait-time" name="reservation[wait_time]"><option value="'+text+'" selected>'+text+'</option><option value="5">5</option><option value="10">10</option><option value="15">15</option><option value="20">20</option><option value="30">30</option><option value="45">45</option><option value="60">60</option><option value="75">75</option><option value="90">90</option></select>');
  },

  status: function(reservation) {
    var element = reservation.find(".status");
    var text = element.text();
    element.html('<select class="update update-status" name="reservation[status]"><option value="'+text+'" selected>'+text+'</option><option value="Waiting">Waiting</option><option value="Seated">Seated</option><option value="Cancelled">Cancelled</option><option value="No-Show">No-Show</option></select>');
  },

  // if we can use remote true, then use it.
  save: function(e) {
    e.preventDefault();
    var id = $(this).closest(".reservation").data("id").toString();
    // this line is repeated, extract into a method.
    var restaurant_id = $(this).closest(".reservation").data("restaurant-id").toString();
    var $that = $(this);
    $.ajax({
      url: "/restaurants/"+restaurant_id+"/reservations/"+id+"/",
      type: "put",
      dataType: "json",
      data: $(this).closest(".reservation").serialize()
    }).done(function(data){
      // extract into method(s)
      $that.closest(".reservation").find("span.status").removeAttr('id').attr('id', "status-"+data.status.toLowerCase());
      $that.closest(".reservation").find("span.name").html(data.name);
      $that.closest(".reservation").find("span.status").html(data.status);
      $that.closest(".reservation").find("span.party-size").html(data.party_size);
      $that.closest(".reservation").find("span.phone-number").html(data.phone_number);
      $that.closest(".reservation").find("span.wait-time").html(data.wait_time);
      $that.closest(".reservation").find("span.seat-time").html(data.estimated_seat_time);
      $that.closest(".table").find(".update-button").html('<input class="edit" type="submit" value="edit">')
      superBadAssTimer = setInterval(function(){updateReservations.getReservationsFromServer()},60000)
    })
  },

  initBang: function() {
    superBadAssTimer = setInterval(function(){updateReservations.getReservationsFromServer()},60000)
    $(".add-reservation-form").on("ajax:success", "#new_reservation", this.addReservation);
    $(".add-reservation-form").on("ajax:error", "#new_reservation", this.errorMessage);

    $(".table").on("click", ".edit", function() { update.init(this) });
    $(".table").on("click", ".save", update.save);
  },

  addReservation: function(e, reservationPartial) {
    $(".table-body").append(reservationPartial);
    // could be moved into a clearReservationFields method.
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
}

var reloadStatusId = function() {
  var element = $('.status');
  // too much logic, could be simplified, statusText = statusId.toUpperCase().replace('-', ' ')
  for(var i=0; i< element.length; i++){
    var statusText = element[i].innerHTML;
    if (statusText == 'Waiting') {
      var statusId = 'status-waiting';
    } else if (statusText == 'Cancelled') {
      statusId = 'status-cancelled';
    } else if (statusText == 'No-Show') {
      statusId = 'status-no-show';
    } else if (statusText == 'Seated') {
      statusId = 'status-seated';
    }
  $($('span.status')[i]).removeAttr('id').attr('id', statusId);
  }
}

$(document).ready(function(){
  update.initBang();
  reloadStatusId();
});
