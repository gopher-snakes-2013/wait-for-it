var ReservationActions = {
  delegations: function() {
    $(".party-size").on("click", this.update);
    $(".rezzy").on("mouseenter", this.showDelete);
    $(".rezzy").on("mouseleave", this.hideDelete);
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
}

$(document).ready(function(){
  ReservationActions.delegations();
})