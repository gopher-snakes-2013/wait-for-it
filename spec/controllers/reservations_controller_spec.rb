require 'spec_helper'

describe ReservationsController do
  before(:each) do
    @restaurant = Restaurant.create(name: "Sourdough Kitchen", email: "sour@kitchen.com", password: "password", password_confirmation: "password")
    @reservation = @restaurant.reservations.new
    @reservation.name = "George"
    @reservation.party_size = 4
    @reservation.phone_number = "555-555-5555"
    @reservation.wait_time = 10
    @reservation.before_wait_time = 10
    @reservation.save
  end

  context "#update" do
    it "should result in an updated name field" do
      put :update, restaurant_id: @restaurant.id, id: @reservation.id, reservation: { name: "john"}
      expect(Reservation.find(@reservation.id).name).to eq("john")
    end
  end

  context "#destroy" do
    it "should delete specified record" do
      expect { delete :destroy, restaurant_id: @restaurant.id, id: @reservation.id }.to change { Reservation.count }.by(-1)
    end
  end

  context "#create" do
    it "should add a valid reservation to the db" do
      expect {
        post :create, restaurant_id: @restaurant.id, reservation: { name: "Nat", party_size: 4, phone_number: '555-555-5555', wait_time: 15, restaurant_id: 1 }
      }.to change { Reservation.count }.by 1
    end

    it "should NOT add an invalid reservation to the db" do
      expect {
        post :create, restaurant_id: @restaurant.id, reservation: { name: nil, party_size: nil, phone_number: nil }
      }.to_not change { Reservation.count }
    end
  end

end
