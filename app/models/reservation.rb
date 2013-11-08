class Reservation < ActiveRecord::Base

  attr_accessible :name, :party_size, :phone_number, :wait_time

	validates_presence_of :name, :party_size
	validates_numericality_of :party_size

  phony_normalize :phone_number, :default_country_code => 'US'
	validates_plausible_phone :phone_number, :presence => true
	validates_plausible_phone :phone_number, :country_code => '1'

  before_save :add_plus_phone_number

  def add_plus_phone_number
    self.phone_number = "+" + self.phone_number
  end
end