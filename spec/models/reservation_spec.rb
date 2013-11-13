require 'spec_helper'

describe Reservation do
  it { should validate_presence_of :name }
  it { should validate_presence_of :party_size }
  it { should validate_presence_of :phone_number }
  it { should validate_presence_of :wait_time }
  it { should validate_presence_of :status }

  it { should validate_numericality_of :party_size }
  it { should validate_numericality_of :wait_time }

  it { should belong_to(:restaurant) }

  before(:each) do
    @restaurant = Restaurant.create(name: "Sourdough Kitchen", email: "sour@kitchen.com", password: "password", password_confirmation: "password")
    @reservation = @restaurant.reservations.new
    @reservation.name = "Jeff"
    @reservation.party_size = 1
    @reservation.phone_number = "555-555-5555"
    @reservation.wait_time = 0
    @reservation.save

    @reservation_2 = @restaurant.reservations.new
    @reservation_2.name = "Cindy"
    @reservation_2.party_size = 2
    @reservation_2.phone_number = "555-555-5555"
    @reservation_2.wait_time = 20
    @reservation_2.save
  end

  it 'should default notified_table_ready to nil' do
    @reservation.notified_table_ready.should be nil
  end

  describe "custom callback methods" do
    context "#add_plus_phone_number" do
      it "should add a plus to normalized phone numbers" do
        expect(@reservation.phone_number).to eq("+15555555555")
      end
    end

    context "generate_unique_key" do
      it "should assign unique_key to a random secure hex key" do
        expect(Reservation.find_by_name("Cindy").unique_key).to be_true
      end
    end
  end

  context "#status" do
    it "should set to default of Waiting" do 
      expect(@reservation.status).to eq "Waiting"
    end
  end

end
