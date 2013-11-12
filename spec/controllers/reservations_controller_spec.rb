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

  context "#update_wait_time" do
    before(:each) do
      @reservation_2 = @restaurant.reservations.new
      @reservation_2.name = "Jim"
      @reservation_2.party_size = 2
      @reservation_2.phone_number = "555-555-5555"
      @reservation_2.wait_time = 0
      @reservation_2.before_wait_time = 0
      @reservation_2.save
    end

    xit "should subtract one from the wait times of all reservations in the db" do
      post :update_wait_time, restaurant_id: @restaurant.id
      expect(Reservation.find_by_name("George").wait_time).to eq(9)
    end

    xit "should not update wait times of 0" do
      post :update_wait_time, restaurant_id: @restaurant.id
      expect(Reservation.find_by_name("Jim").wait_time).to eq(0)
    end

  end

end
