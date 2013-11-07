class Reservation < ActiveRecord::Base
	validates_presence_of :name, :party_size
	validates_numericality_of :party_size
	validates_uniqueness_of :phone_number

	validates_plausible_phone :phone_number, :presence => true
	validates_plausible_phone :phone_number, :country_code => '1'
end