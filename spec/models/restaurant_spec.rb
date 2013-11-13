require 'spec_helper'

describe Restaurant do
	it { should have_many(:reservations) }
  it { should validate_presence_of :email }
	it { should validate_presence_of :name }
	it { should validate_presence_of :password }
	it { should validate_uniqueness_of :email }
  it { should have_secure_password }

  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("blah@email.com").for(:email) }

  before(:each) do
    @restaurant = Restaurant.create(name: "Sourdough Kitchen", email: "sour@kitchen.com", password: "password", password_confirmation: "password")
    @reservation = @restaurant.reservations.new
    @reservation.name = "Jeff"
    @reservation.party_size = 1
    @reservation.phone_number = "555-555-5555"
    @reservation.wait_time = 20
    @reservation.save

    @reservation_2 = @restaurant.reservations.new
    @reservation_2.name = "Cindy"
    @reservation_2.party_size = 2
    @reservation_2.phone_number = "555-555-5555"
    @reservation_2.wait_time = 10
    @reservation_2.save
  end

  describe "#max_wait_time" do
    it "should return the max wait time for the restaurant" do
      expect(@restaurant.max_wait_time).to eq(20)
    end
  end

  describe "#current_reservations" do
    it "should return an array of current reservations sorted by seat time" do
      expect(@restaurant.current_reservations).to eq([@reservation_2, @reservation])
    end
  end

end

