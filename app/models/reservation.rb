class Reservation < ActiveRecord::Base
  attr_accessible :name, :party_size, :phone_number, :wait_time, :estimated_seat_time
  belongs_to :restaurant

  validates_presence_of :name, :party_size
  validates_numericality_of :party_size, :wait_time

  phony_normalize :phone_number, :default_country_code => 'US'
  validates_plausible_phone :phone_number, :presence => true
  validates_plausible_phone :phone_number, :country_code => '1'

  before_save :add_plus_phone_number
  after_update :update_all_wait_times
  after_create :send_text_upon_new_reservation

  def add_plus_phone_number
    self.phone_number = "+" + self.phone_number
  end

  def send_text_upon_new_reservation
    TwilioHelper.send_on_waitlist(self.phone_number,
      "Hi #{self.name}, you've been added to the waitlist. Your wait is approximately #{self.wait_time} minutes.")
  end

  def update_all_wait_times
    additional_wait = self.wait_time
    Reservation.all.each do |reservation|
      if reservation.id > self.id
        reservation.update_attributes(wait_time: (reservation.wait_time + additional_wait))
      end
    end
    additional_wait
  end

  def initial
    self.name[0].upcase
  end

  def phone_number_obscured
    "XXX-X" + self.phone_number.slice(-3,3)
  end

  def estimated_seating
    t = self.updated_at.localtime
    t += self.wait_time * 60
    if (Time.now <=> t) == -1
      t.strftime("%I:%Mp")
    else
      "soon"
    end
  end

  def as_json(options={})
    {initial: initial,
      party_size: self.party_size,
      phone_number: phone_number_obscured,
      estimated_seating: estimated_seating
    }
  end

end
