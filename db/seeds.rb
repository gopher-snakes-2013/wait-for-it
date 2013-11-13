20.times do
  restaurant = Restaurant.new
  restaurant.name = Faker::Commerce.color.capitalize
  restaurant.email = restaurant.name.downcase + "@mail.com"
  restaurant.password = "password"
  restaurant.password_confirmation = "password"
  restaurant.save
end

Restaurant.all.each do |restaurant|
  6.times do
    reservation = restaurant.reservations.new
    reservation.name = Faker::Name.first_name
    reservation.party_size = 1 + rand(8)
    reservation.phone_number = Faker::PhoneNumber.cell_phone.gsub(/\s.*/, "")
    reservation.wait_time = 30
    reservation.save
  end
end