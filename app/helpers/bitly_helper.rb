module BitlyHelper

  def self.shorten_url(reservation)
    bitly = Bitly.client
    restaurant_id = reservation.restaurant_id.to_s
    id = reservation.id.to_s
    unique = reservation.unique_key
    bitly.shorten('http://stillwaiting.herokuapp.com/restaurants/'+restaurant_id+'/reservations/'+id+'?guest='+unique).short_url
  end

end