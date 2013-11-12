var update = {

  init: function() {
    var $edit = $(this)
    var reservation = $(this).closest(".reservation");
    var id = reservation.data("id");
    update.partySize(reservation);
    update.guestName(reservation);
    update.phoneNumber(reservation);
    update.waitTime(reservation);
    update.status(reservation);

    $edit.closest(".update-button").html('<input class="save" name="commit" type="submit" value="save">');
    $(".edit").remove();
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
    var potential_wait_times = ["10","15","20","25","30"]
    element.html('<select class="update update-wait-time" name="reservation[wait_time]"><option value="'+text+'" selected>'+text+'</option><option value="10">10</option><option value="20">20</option><option value="30">30</option></select>');
  },

  status: function(reservation) {
    var element = reservation.find(".status");
    element.html('<select class="update update-status" name="reservation[status]"><option value="Open">Open</option><option value="Seated">Seated</option><option value="Cancelled">Cancelled</option><option value="No-Show">No-Show</option></select>');
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
      data: $(this).closest(".reservation").serialize()
    }).done(function(data){
      var statusId = updateStatusId(data);
      $that.closest(".reservation").find("span.status").removeAttr('id').attr('id', statusId);
      $that.closest(".reservation").find("span.name").html(data.name);
      $that.closest(".reservation").find("span.status").html(data.status);
      $that.closest(".reservation").find("span.party-size").html(data.party_size);
      $that.closest(".reservation").find("span.phone-number").html(data.phone_number);
      $that.closest(".reservation").find("span.wait-time").html(data.wait_time);
      $that.closest(".reservation").find("span.seat-time").html(data.estimated_seat_time);
      $that.closest(".table").find(".update-button").html('<input class="edit" type="submit" value="edit">')
    })
  }
}

var reservationActions = {

  init: function() {
    $(".add-reservation-form").on("ajax:success", "#new_reservation", this.addReservation);
    $(".add-reservation-form").on("ajax:error", "#new_reservation", this.errorMessage);
    $(".add-reservation-form").on("ajax:success", setStatusId);

    $(".table").on("click", ".edit", update.init);
    $(".table").on("click", ".save", update.save);
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
}

var setStatusId = function() {
  $("span.status").last().attr('id', 'status-open');
}


var updateStatusId = function(data) {
 var statusText = data.status;
 if (statusText == 'Open') {
  var statusId = 'status-open';
  } else if (statusText == 'Cancelled') {
    statusId = 'status-cancelled';
  } else if (statusText == 'No-Show') {
    statusId = 'status-no-show';
  } else if (statusText == 'Seated') {
    statusId = 'status-seated';
  }
  return statusId;
}

var reloadStatusId = function() {
  var element = $('.status');
  for(var i=0; i< element.length; i++){
    var statusText = element[i].innerHTML;
    if (statusText == 'Open') {
      var statusId = 'status-open';
    } else if (statusText == 'Cancelled') {
      statusId = 'status-cancelled';
    } else if (statusText == 'No-Show') {
      statusId = 'status-no-show';
    } else if (statusText == 'Seated') {
      statusId = 'status-seated';
    }
  $($('span.status')[i]).attr('id', statusId);
  }
}


$(document).ready(function(){
  reservationActions.init();
  reloadStatusId();
});
