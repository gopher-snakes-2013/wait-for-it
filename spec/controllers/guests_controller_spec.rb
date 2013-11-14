require 'spec_helper'

describe GuestsController do
  before(:each) do
    @restaurant = Restaurant.create(name: "Sourdough Kitchen", email: "sour@kitchen.com", password: "password", password_confirmation: "password")
    @guest = Guest.create({name: "Laura", phone_number: "555-555-5555", email: "laura@mail.com", password: "password", password_confirmation: "password" })
  end

  it "#index" do
    get :index
    response.status.should eq(200)
  end

  it "#new" do
    get :new
    response.status.should eq(200)
  end

  it "#show" do
    get :show, id: @guest.id
    response.status.should eq(200)
  end

  it "#restaurants" do
    get :restaurants, id: @guest.id
    response.status.should eq(200)
  end

  context "#create" do
    it "should add a valid guest to the db" do
      expect {
        post :create, guest: {name: "Paul", phone_number: "555-555-5555", email: "paul@mail.com", password: "password", password_confirmation: "password" }
      }.to change { Guest.count }.by(1)
    end

    it "should NOT add an invalid guest to the db" do
      expect {
        post :create, guest: {name: "Jeff", password: "password"}
      }.to_not change { Guest.count }
    end
  end

  context "#reservation_request" do
    it "should add a valid reservation to the db" do
      expect {
        post :reservation_request, id: @guest.id, restaurant_id: @restaurant.id, reservation: { name: "Jeff", party_size: 2, phone_number: "555-555-5555", wait_time: 10, status: "Pending" }
        }.to change { Reservation.count }.by(1)
    end
    it "should NOT add an invalid reservation to the db" do
      expect {
        post :reservation_request, id: @guest.id, restaurant_id: @restaurant.id, reservation: { name: "Jeff" }
      }.to_not change { Reservation.count }
    end
  end

end