require 'spec_helper'

feature "Restaurant Registration Page" do
  before(:each) do
    visit new_restaurant_path
  end

  scenario "user visits Registration page" do
    expect(current_path).to eq(new_restaurant_path)
    
    expect(page).to have_content("Restaurant Registration")
  end

  context "user registers their restaurant" do
    before(:each) do
      fill_in("restaurant[name]", with: "Sourdough Kitchen")
      fill_in("restaurant[email]", with: "sour@kitchen.com")
      fill_in("restaurant[password]", with: "password")
      fill_in("restaurant[password_confirmation]", with: "password")
      click_on("Create Account")
    end

    scenario "page redirects to home" do
      expect(current_path).to eq(root_path)
    end
  end

  context "user submits an invalid restaurant" do
    before(:each) do
      fill_in("restaurant[name]", with: "")
      fill_in("restaurant[email]", with: "")
      fill_in("restaurant[password]", with: "password")
      fill_in("restaurant[password_confirmation]", with: "password")
      click_on("Create Account")
    end

    scenario "user sees an error message" do
      expect(page).to have_content("Try Again!")
    end

    scenario "stays on registration page" do
      expect(current_path).to eq(new_restaurant_path)
    end
  end
end
