require 'spec_helper'

feature "Homepage" do
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
      fill_in("reservation[party_size]", with: 2)
      fill_in("reservation[phone_number]", with: "8581000000")
      fill_in("reservation[wait_time]", with: 10)
      click_on("Create Reservation")
    end

    scenario "the new reservation is created" do
      expect(page).to have_content("Paul")
    end

    scenario "page redirects to home" do
      expect(current_path).to eq(root_path)
    end
  end

  context "user submits an invalid reservation" do
    before(:each) do
      click_on("Create Reservation")
    end

    scenario "user sees an error message" do
      expect(page).to have_content("Try Again.")
    end

    scenario "is redirected to home" do
      expect(current_path).to eq(root_path)
    end
  end

  context "user attempts to delete a reservation" do
    before(:each) do
      fill_in("reservation[name]", with: "Paul")
      fill_in("reservation[party_size]", with: 2)
      fill_in("reservation[phone_number]", with: "8581000000")
      fill_in("reservation[wait_time]", with: 10)
      click_on("Create Reservation")
      click_on('delete')
    end
    scenario "user deletes an existing reservation" do
      page.should_not have_content("Paul")
    end
  end
end