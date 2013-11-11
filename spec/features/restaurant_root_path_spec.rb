require 'spec_helper'

feature 'Restaurant Sign-in Page' do
	before(:each) do
		visit root_path
	end

	scenario 'Restaurant user visits Sign-in page' do
		expect(current_path).to eq(root_path)
		expect(page).to have_content('Sign In')
	end


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
			visit root_path
		end
		
		scenario 'Registered Restaurant can see their name on the root page' do

			visit root_path
			expect(current_path).to eq(root_path)
			expect(page).to have_content('Sourdough Kitchen')
		end
	end


end