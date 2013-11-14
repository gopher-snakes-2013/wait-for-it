var Message = {
  sendTextTableReady: function(reservationId){
    var that = this
    $.ajax({
      url: "/messages",
      type: "post",
      data: {id: reservationId},
      data_type: "json"
    }).done(function(){
      $(that).removeClass("message-ready")
      $(that).addClass("ready-message-sent")
      $("error-message").empty()
    }).error(function(){
      $("error-message").text("SMS failed :(")
    })
  },
  SMSButtonEvent: function(){
    var self = this;
    $(".table-body").on("click", "div.message-ready", function(){
      var reservationId = $(this).closest(".reservation").data("id")
      var boundSendTextTableReady = self.sendTextTableReady.bind(this)
      boundSendTextTableReady(reservationId)
    })
  }
}

$(document).ready(function(){
  Message.SMSButtonEvent();
})