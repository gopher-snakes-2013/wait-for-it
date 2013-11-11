require 'spec_helper'

describe Reservation do
  it { should validate_presence_of :name }
  it { should validate_presence_of :party_size }
  it { should validate_presence_of :phone_number }

  it { should validate_numericality_of :party_size }
  it { should validate_numericality_of :wait_time }

  it { should belong_to(:restaurant) }

  it 'should default notified_table_ready to nil' do
    @reservation = Reservation.create(name:"Jeff", phone_number:"14154154000",wait_time:40)
    @reservation.notified_table_ready.should be nil
  end

  describe "custom callback methods" do
    let(:reservation) { Reservation.create name: "George",
                                           party_size: 4,
                                           phone_number: "555-555-5555",
                                           wait_time: 10 }


    context "#calculate_seat_time" do
      xit "should save an estimated seat time" do
        expect(reservation.estimated_seat_time).to be_a(Time)
      end
    end

    context "#add_plus_phone_number and #phony_normalize" do
      it "should add a plus to normalized phone numbers" do
        expect(reservation.phone_number).to eq("+15555555555")
      end
    end

    context "#update_all_wait_times" do
      before(:each) do
        @reservation = Reservation.create(name: "Laura",
                           party_size: 3,
                           phone_number: "555-555-5555",
                           wait_time: 10 )
        @next_reservation = Reservation.create(name: "Nat",
                           party_size: 1,
                           phone_number: "555-555-5555",
                           wait_time: 20 )
        Reservation.create(name: "Paul",
                           party_size: 2,
                           phone_number: "555-555-5555",
                           wait_time: 30 )
      end

      xit "should update the wait times of reservations after the updated one" do
        @reservation.update_attributes(wait_time: 40)
        expect(@next_reservation.wait_time).to eq(30)
      end
    end
  end

end
