class Reservation < ActiveRecord::Base
  attr_accessible :name, :party_size, :phone_number, :wait_time, :estimated_seat_time, :status, :restaurant_id
  belongs_to :restaurant, :guest

  STATUSES = {
    :waiting => "Waiting",
    :cancelled => "Cancelled",
    :no_show => "No-Show",
    :seated => "Seated"
  }

  validates :name, :party_size, :wait_time, :status, :presence => true
  validates_numericality_of :party_size, { only_integer: true, less_than_or_equal_to: 10, greater_than: 0 }
  validates_numericality_of :wait_time

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
    TwilioHelper.table_ready(self.phone_number, self.restaurant.name)
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

  def archive!
    self.archived = true
  end

  def archived?
    self.archived
  end

  def time_range_display_start
    minutes = self.estimated_seat_time.localtime.strftime("%M").to_i - 8
    hour = self.estimated_seat_time.localtime.strftime("%l")
    time = RounderHelper.round_up(hour, minutes.to_s)
    start_mins = time[:minutes]
    start_hour = time[:hour]
    start_time = start_hour + ":" + start_mins
    { start_time: start_time, minutes: start_mins.to_i }
  end

  def time_range_display_end
    minutes = self.time_range_display_start[:minutes] + 10
    hour = self.estimated_seat_time.localtime.strftime("%l")
    am_pm = self.estimated_seat_time.localtime.strftime("%P")
    time = RounderHelper.round_up(hour, minutes.to_s)
    end_mins = time[:minutes]
    end_hour = time[:hour]
    end_time = end_hour + ":" + end_mins + am_pm
  end

end