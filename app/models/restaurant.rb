class Restaurant < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :reservations

  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  has_secure_password

  def update_max_wait_time
		reservations_sorted_by_wait_time = self.reservations.map { |x| x.wait_time }.sort.last
		if reservations_sorted_by_wait_time.nil?
			self.max_wait_time = 0
		else	
			self.max_wait_time = reservations_sorted_by_wait_time
		end
  end

end

