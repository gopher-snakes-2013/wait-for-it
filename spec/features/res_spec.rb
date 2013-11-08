require 'spec_helper'

feature "Homepage" do
  before(:each) do
    visit root_path
  end

  scenario "user can see visit home page" do
    expect(current_path).to eq(root_path)
  end

  scenario "user can create a new reservation" do
    fill_in("reservation[name]", with: "Paul")
    fill_in("reservation[party_size]", with: 2)
    fill_in("reservation[phone_number]", with: "8581000000")
    fill_in("reservation[wait_time]", with: 10)
    click_on("Create Reservation")

    expect(page).to have_content("Paul")
  end

  scenario "user sees an error message when reservation was not created" do
    click_on("Create Reservation")

    expect(page).to have_content("Try Again.")
  end
end