require 'spec_helper'

feature "Restaurant's Reservation Page", js: true do
  before(:each) do
    @test_restaurant = Restaurant.create(name: "What the Duck", email: "duck@what.com", password: "password", password_confirmation: "password")
    visit root_path
    fill_in("email", with: "duck@what.com")
    fill_in("password", with: "password")
    click_on("Login")
    visit restaurant_reservations_path(@test_restaurant.id)
  end

  scenario "user visits home page" do
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

    scenario "user sees an error message" do
      expect(page).to have_content("Try Again.")
    end
  end
end
