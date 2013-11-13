require 'spec_helper'

feature "Restaurant's Reservation Page" do
  before(:each) do
    @test_restaurant = Restaurant.create(name: "What the Duck", email: "duck@what.com", password: "password", password_confirmation: "password")
    visit root_path
    fill_in("email", with: "duck@what.com")
    fill_in("password", with: "password")
    click_on("Login")
    visit restaurant_reservations_path(@test_restaurant.id)
  end

  xscenario "user visits home page" do
    expect(current_path).to eq(restaurant_reservations_path(@test_restaurant.id))
    expect(page).to have_content("What the Duck")
  end

  context "user submits a valid reservation" do
    before(:each) do
      fill_in("reservation[name]", with: "Paul")
      fill_in("reservation_party_size", with: 2)
      fill_in("reservation[phone_number]", with: "555-555-5555")
      fill_in("reservation[wait_time]", with: 10)
      click_on("Create Reservation")
    end

    scenario "the new reservation is created and complete" do
      expect(page).to have_content("Paul")
      expect(page).to have_content(2)
      expect(page).to have_content("555-555-5555")
      expect(page).to have_content(10)
    end
  end

  context "user submits an invalid reservation" do
    before(:each) do
      click_on("Create Reservation")
    end

    xscenario "user sees an error message" do
      expect(page).to have_content("Try Again.")
    end
  end
end

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

    xscenario 'Registered Restaurant can see their name on their restaurant page' do
      visit restaurant_reservations_path(1)
      expect(page).to have_content('Sourdough Kitchen')
    end
  end
end
