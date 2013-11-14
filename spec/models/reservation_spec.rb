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

  it 'should default to archived false' do 
    @reservation.archived.should be false
  end

  it 'should not allow non-integer party sizes' do 
    @reservation.party_size = 1.1
    expect(@reservation.invalid?).to be_true
  end 

  it 'should not allow party sizes over 10' do 
    @reservation.party_size = 11
    expect(@reservation.invalid?).to be_true
  end

  it 'should not allow negative party sizes' do 
    @reservation.party_size = -1
    expect(@reservation.invalid?).to be_true
  end

  it 'should not allow non-integer wait times' do 
    @reservation.wait_time = 1.1
    expect(@reservation.invalid?).to be_true
  end 

  it 'should not allow party sizes over 120' do 
    @reservation.wait_time = 121
    expect(@reservation.invalid?).to be_true
  end

  it 'should not allow negative wait times on update' do 
    @reservation.wait_time = -1
    expect(@reservation.invalid?).to be_true
  end

  describe "custom callback methods" do
    context "#add_plus_phone_number" do
      it "should add a plus to normalized phone numbers" do
        expect(@reservation.add_plus_phone_number).to eq("+15555555555")
      end
    end

    context "#generate_unique_key" do
      it "should assign unique_key to a random secure hex key" do
        expect(Reservation.find_by_name("Cindy").unique_key).to be_true
      end
    end

    context "#add_estimated_seat_time" do
      it "should update the estimated seat time in the db when wait time is changed" do
        @time_now = Time.parse("Oct 31 2012")
        Time.stub(:now).and_return(@time_now)
        @reservation.update_attributes(wait_time: 10)
        expect(@reservation.estimated_seat_time.to_s).to eq((Time.now + 10*60).getutc.strftime('%F %T UTC'))
      end
    end

    context "#send_text_table_ready" do
        let(:table_ready) { double(:table_ready) }
      it "should change the reservation's notified_table_ready status to true" do
        @reservation.send_text_table_ready
        expect(@reservation.notified_table_ready).to be_true
      end
      it "should call the Twilio helper to send a text" do 
        TwilioHelper.should_receive(:table_ready)
        @reservation.send_text_table_ready
      end
    end

  context "#send_text_upon_new_reservation" do 
      let(:send_on_waitlist) { double(:send_on_waitlist) }
    it "should send a message with the Twilio helper" do
      @reservation.stub(:short_url).and_return("bit.ly")
      TwilioHelper.should_receive(:send_on_waitlist)
      @reservation.send_text_upon_new_reservation
    end
  end

  context "#estimated_seat_time_display" do
    it "should return an hour:minute am/pm time string" do
      time = (Time.now + 20*60).localtime.strftime("%l:%M%P")
      expect(@reservation_2.estimated_seat_time_display).to eq(time)
    end
  end
end

  context "#wait_time_display" do
    it "should return a rounded up wait time" do
      time = ((@reservation_2.estimated_seat_time - Time.now)/60).round
      expect(@reservation_2.wait_time_display).to eq(time)
    end
  end

  context "#time_range_display_start" do
    it "should return a start time with the hour:minute format" do
      minutes = @reservation_2.estimated_seat_time.localtime.strftime("%M").to_i
      hour = @reservation_2.estimated_seat_time.localtime.strftime("%l")
      time = RounderHelper.round_up(hour, minutes)

      expect(@reservation_2.time_range_display_start).to eq(time[:hour]+":"+time[:minutes])
    end
  end

  context "#time_range_display_end" do
    it "should return an end time with the hour:minute am/pm format" do
      minutes = @reservation_2.estimated_seat_time.localtime.strftime("%M").to_i + 10
      hour = @reservation_2.estimated_seat_time.localtime.strftime("%l")
      am_pm = @reservation_2.estimated_seat_time.localtime.strftime("%P")
      time = RounderHelper.round_up(hour, minutes.to_s)

      expect(@reservation_2.time_range_display_end).to eq("#{time[:hour]}:#{time[:minutes]}#{am_pm}")
    end
  end

  context "#status" do
    it "should set to default of Waiting" do 
      expect(@reservation.status).to eq "Waiting"
    end
  end

  context "#archive!" do 
    it "should change status of reservation to archive" do 
      expect {
        @reservation.archive!
      }.to change{@reservation.archived}.to true
    end
  end
end
