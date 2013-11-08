class Reservation < ActiveRecord::Base
  attr_accessible :name, :party_size, :phone_number, :wait_time

	validates_presence_of :name, :party_size
	validates_numericality_of :party_size, :wait_time

  phony_normalize :phone_number, :default_country_code => 'US'
	validates_plausible_phone :phone_number, :presence => true
	validates_plausible_phone :phone_number, :country_code => '1'

  before_save :add_plus_phone_number, :calculate_seat_time
  after_create :send_text_upon_new_reservation

  def add_plus_phone_number
    self.phone_number = "+" + self.phone_number
  end

  def send_text_upon_new_reservation
    TwilioHelper.send_on_waitlist(self.phone_number,
      "Hi #{self.name}, you've been added to the waitlist. Your wait is approximately #{self.wait_time} minutes.")
  end

  def calculate_seat_time
    
  end
end
