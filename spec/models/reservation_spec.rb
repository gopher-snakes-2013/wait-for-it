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

  it 'should default notified_table_ready to nil' do
    reservation = Reservation.create(name: "Jeff", party_size: 1, phone_number: "14154154000", wait_time: 20, before_wait_time: 20)
    reservation.notified_table_ready.should be nil
  end

  describe "custom callback methods" do
    let!(:reservation) { Reservation.create name: "George",
                                           party_size: 4,
                                           phone_number: "555-555-5555",
                                           wait_time: 10,
                                           before_wait_time: 10 }

    context "#add_plus_phone_number and #phony_normalize" do
      it "should add a plus to normalized phone numbers" do
        expect(reservation.phone_number).to eq("+15555555555")
      end
    end

    context "#update_all_wait_times" do
      it "should update all subsequent wait times in the db" do
        next_reservation = Reservation.create(name: "Jeff", party_size: 1, phone_number: "14154154000", wait_time: 20, before_wait_time: 20)
        reservation.wait_time = 20
        reservation.save
        expect(Reservation.find_by_name("Jeff").wait_time).to eq(30)
      end
    end
  end


  context "#phone_number_obscured" do 
    before(:each) do
      @reservation = Reservation.create(name: "Laura",
                           party_size: 3,
                           phone_number: "555-555-5555",
                           wait_time: 10 )
    end
    it "should obscure phone number" do 
      expect(@reservation.phone_number_obscured).to eq "XXX-X555"
    end
  end
  context "#initial" do 
  end

  context "#estimated_seating" do 
         before(:each) do
        @reservation = Reservation.create(name: "Laura",
                           party_size: 3,
                           phone_number: "555-555-5555",
                           wait_time: 0,
                           before_wait_time: 0 )
        @next_reservation = Reservation.create(name: "Nat",
                           party_size: 1,
                           phone_number: "555-555-5555",
                           wait_time: 20,
                           before_wait_time: 20)
      end
      
      it "should return 'soon' for reservations that are at current time" do 
        expect(@reservation.estimated_seating).to eq "soon"
      end

      it "should return a local time for reservations more than current time" do
        expect(@next_reservation.estimated_seating).to eq (Time.now()+20*60).localtime.strftime("%I:%Mp")
      end
    end

end
