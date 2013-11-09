require 'spec_helper'

feature "Home Page" do
  before(:each) do
    visit root_path
  end

  context "restaurant can sign up" do
    scenario "restaurant signs up" do
      click_on "register"
      fill_in("restaurant[name]", with: "Hops")
      fill_in("restaurant[email]", with: "hops@me.com")
      fill_in("restaurant[password]", with: "password")
      fill_in("restaurant[password_confirmation]", with: "password")
      click_on "Create Account"
      expect(page).to have_content("Hops")
    end
  end
end

feature "Restaurant Page" do
  before(:each) do
    visit root_path
  end

  scenario "user visits home page" do
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Wait For It")
  end

  context "user submits a valid reservation" do
    before(:each) do
      fill_in("reservation[name]", with: "Paul")
      fill_in("reservation_party_size", with: 2)
      fill_in("reservation[phone_number]", with: "555-555-5555")
      fill_in("reservation[wait_time]", with: 10)
      click_on("Create Reservation")
    end

    scenario "the new reservation is created" do
      expect(page).to have_content("Paul")
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
