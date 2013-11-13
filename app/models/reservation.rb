class Reservation < ActiveRecord::Base
  attr_accessible :name, :party_size, :phone_number, :wait_time, :estimated_seat_time, :status, :restaurant_id
  belongs_to :restaurant

  STATUSES = {
    :open => "Open",
    :cancelled => "Cancelled",
    :no_show => "No-Show",
    :seated => "Seated"
  }

  validates :name, :party_size, :wait_time, :status, :presence => true
  validates_numericality_of :party_size, :wait_time

  phony_normalize :phone_number, :default_country_code => 'US'
  validates_plausible_phone :phone_number, :presence => true, :country_code => '1'

  validates :status, inclusion: { in: STATUSES.values }

  before_save :add_plus_phone_number, :add_estimated_seat_time

  before_create :generate_unique_key
  after_create :send_text_upon_new_reservation


  STATUSES.keys.each do |name|
    define_method "#{name}?" do
      self.status == STATUSES[name]
    end
    define_method "#{name}!" do
      self.update_attribute :status, STATUSES[name]
    end
  end

  def thirty_minutes_before_current_time
    self.estimated_seat_time < (Time.now - 30*60)
  end

  def add_plus_phone_number
    self.phone_number = "+" + self.phone_number
  end

  def send_text_upon_new_reservation
    TwilioHelper.send_on_waitlist(self.phone_number,
      "Hi #{self.name}, you've been added to #{self.restaurant.name}'s waitlist. Your wait is approximately #{self.wait_time} minutes. #{self.short_url}")
  end

  def send_text_table_ready
    self.notified_table_ready = true
    self.save
    TwilioHelper.table_ready(self.phone_number)
  end

  def generate_unique_key
    self.unique_key = SecureRandom.hex(10)
  end

  def short_url
    BitlyHelper.shorten_url(self)
  end

  def as_json(options={})
    {name: self.name,
      id: self.id,
      party_size: self.party_size,
      phone_number: self.phone_number.phony_formatted(normalize: :US, format: :national, spaces: '-'),
      estimated_seating: self.estimated_seat_time_display,
      wait_time: self.wait_time_display,
      status: self.status,
      notified: self.notified_table_ready,
      restaurant_id: self.restaurant_id
    }
  end

  def add_estimated_seat_time
    self.estimated_seat_time = Time.now + self.wait_time*60
  end

  def estimated_seat_time_display
    self.estimated_seat_time.localtime.strftime("%l:%M%P")
  end

  def wait_time_display
    ((self.estimated_seat_time - Time.now)/60).round
  end

  # NAT!
  # run this after:
  # new reservation
  # update reservation
  # destroy reservation (or status change)
  def update_restaurant_wait_time
    self.restaurant.update_max_wait_time
  end
end
