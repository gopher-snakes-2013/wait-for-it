require 'spec_helper'

feature "Restaurant Registration Page" do
  context "restaurant registration" do
    before(:each) do
      visit new_restaurant_path
    end

    scenario "new restaurant visits Registration page" do
      expect(current_path).to eq(new_restaurant_path)
      expect(page).to have_content("Restaurant Registration")
    end

    context "new restaurant signs up for account" do
      before(:each) do
        fill_in("restaurant[name]", with: "Sourdough Kitchen")
        fill_in("restaurant[email]", with: "sour@kitchen.com")
        fill_in("restaurant[password]", with: "password")
        fill_in("restaurant[password_confirmation]", with: "password")
        click_on("Create Account")
      end

      scenario "page redirects to home" do
        @restaurant = Restaurant.find_by_name("Sourdough Kitchen")
        expect(current_path).to eq(restaurant_reservations_path(@restaurant.id))
      end
    end
  end

  context "user submits an invalid restaurant" do
    before(:each) do
      visit new_restaurant_path
      fill_in("restaurant[name]", with: "")
      fill_in("restaurant[email]", with: "")
      fill_in("restaurant[password]", with: "password")
      fill_in("restaurant[password_confirmation]", with: "password")
      click_on("Create Account")
    end

    xscenario "user sees an error message" do
      expect(page).to have_content("Try Again!")
    end

    xscenario "stays on registration page" do
      expect(current_path).to eq(new_restaurant_path)
    end
  end

  context "user signs into their restaurant's existing account" do
    before(:each) do
      @test_restaurant = Restaurant.create(name: "What the Duck", email: "duck@what.com", password: "password", password_confirmation: "password")
    end

    scenario "restaurant logs in" do
      visit root_path
      fill_in "email", with: "duck@what.com"
      fill_in "password", with: "password"
      click_on("Login")
      expect(page).to have_content("What the Duck")
    end
  end
end
