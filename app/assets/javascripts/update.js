var update = function() {
  var id = $(this).data("id");
  var text = $(this).text();
  var formTemplate = '<form action="/reservations/'+id+'" class="update" method="post"><input name="_method" type="hidden" value="put"><input class="updated-party-size" name="reservation[party_size]" value="'+text+'"></form>';
  $(this).html(formTemplate);
  $(".party-size").unbind();
}

$(document).ready(function(){
  $(".party-size").on("click", update);
})