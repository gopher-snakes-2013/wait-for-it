require 'spec_helper'

describe Reservation do
  it { should validate_presence_of :name }
  it { should validate_presence_of :party_size }
  it { should validate_presence_of :phone_number }
  it { should validate_presence_of :wait_time }
  it { should validate_presence_of :before_wait_time }

  it { should validate_numericality_of :party_size }
  it { should validate_numericality_of :wait_time }
  it { should validate_numericality_of :before_wait_time }

  it { should belong_to(:restaurant) }

  before(:each) do
    @restaurant = Restaurant.create(name: "Sourdough Kitchen", email: "sour@kitchen.com", password: "password", password_confirmation: "password")
    @reservation = @restaurant.reservations.new
    @reservation.name = "Jeff"
    @reservation.party_size = 1
    @reservation.phone_number = "555-555-5555"
    @reservation.wait_time = 0
    @reservation.before_wait_time = 0
    @reservation.save

    @reservation_2 = @restaurant.reservations.new
    @reservation_2.name = "Cindy"
    @reservation_2.party_size = 2
    @reservation_2.phone_number = "555-555-5555"
    @reservation_2.wait_time = 20
    @reservation_2.before_wait_time = 20
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

    context "#update_all_wait_times" do
      xit "should update all subsequent wait times for that restaurant in the db" do
        @reservation.wait_time = 20
        @reservation.save
        expect(Reservation.find_by_name("Cindy").wait_time).to eq(30)
      end
    end

    context "generate_unique_key" do
      it "should assign unique_key to a random secure hex key" do
        expect(Reservation.find_by_name("Cindy").unique_key).to be_true
      end
    end
  end


  context "#phone_number_obscured" do
    it "should obscure phone number" do
      expect(@reservation.phone_number_obscured).to eq "XXX-X555"
    end
  end

  context "#estimated_seating" do
      it "should return a local time for reservations more than current time" do
        expect(@reservation_2.estimated_seating).to eq (Time.now()+20*60).localtime.strftime("%I:%Mp")
      end

      it "should return 'soon' for reservations that are at current time" do
        expect(@reservation.estimated_seating).to eq "soon"
      end

    end

end
