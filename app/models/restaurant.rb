class Restaurant < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :reservations

  validates_presence_of :password, on: :create
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([\w\!\#\z\%\&\'\*\+\-\/\=\?\\A\`{\|\}\~]+\.)*[\w\+-]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)\z/i, on: :create

  has_secure_password

  # NAT! :)
  def update_max_wait_time
		reservation_with_longest_wait_time = self.reservations.map { |x| x.wait_time }.sort.last
    self.max_wait_time = reservation_with_longest_wait_time.nil? ? 0 : reservation_with_longest_wait_time
  end

  def current_reservations
    self.reservations.reject do |reservation|
      reservation.thirty_minutes_before_current_time #|| reservation.archived?
    end.sort_by { |reservation| reservation.estimated_seat_time }
  end

end

