require 'spec_helper'

feature 'Restaurant Page' do
	context "new restaurant signs up for account" do
		before(:each) do
			visit new_restaurant_path
			fill_in("restaurant[name]", with: "Sourdough Kitchen")
			fill_in("restaurant[email]", with: "sour@kitchen.com")
			fill_in("restaurant[password]", with: "password")
			fill_in("restaurant[password_confirmation]", with: "password")
			click_on("Create Account")
			fill_in("reservation[name]", with: "Customer Joe")
			fill_in("reservation[party_size]", with: "sour@kitchen.com")
			fill_in("reservation[phone_number]", with: "1111111111")
			fill_in("reservation[wait_time]", with: "10")
			click_on('Create Reservation')
		end

		scenario 'Registered Restaurant can see their name on their restaurant page' do
			visit restaurant_reservations_path(1)
			expect(page).to have_content('Sourdough Kitchen')
		end
	end
end