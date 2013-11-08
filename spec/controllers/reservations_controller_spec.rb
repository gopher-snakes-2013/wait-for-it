require 'spec_helper'

describe ReservationsController do
  it "#index" do
    get :index
    response.status.should eq(200)
  end

  context "#create" do
    it "should add a valid reservation to the db" do
      expect {
        post :create, reservation: {name: "Nat", party_size: 4, phone_number: '650-500-5000', wait_time: 15 }
      }.to change { Reservation.count }.by 1
    end

    it "should NOT add an invalid reservation to the db" do
      expect {
        post :create, reservation: { name: nil, party_size: nil, phone_number: nil }
      }.to_not change { Reservation.count }
    end
  end

end