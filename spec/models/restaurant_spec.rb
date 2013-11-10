require 'spec_helper'

describe Restaurant do
  it { should have_many(:reservations) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should validate_uniqueness_of :email }
end