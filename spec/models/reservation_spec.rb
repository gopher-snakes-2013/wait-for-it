require 'spec_helper'

describe Reservation do
  it { should validate_presence_of :name }
  it { should validate_presence_of :party_size }
  it { should validate_presence_of :phone_number }

  it { should validate_numericality_of :party_size }
  it { should validate_numericality_of :wait_time }

  it 'should default notified_table_ready to false' do 
    let(:reservation) {Restaurant.create(name:"Jeff", phone_number:"14154154000",wait_time:40)}
    reservation.notified_table_ready.should == false
  end
end