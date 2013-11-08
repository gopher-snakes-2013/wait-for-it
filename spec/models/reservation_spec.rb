require 'spec_helper'

describe Reservation do
  it { should validate_presence_of :name }
  it { should validate_presence_of :party_size }
  it { should validate_presence_of :phone_number }

  it { should validate_numericality_of :party_size }
  it { should validate_numericality_of :wait_time }

end