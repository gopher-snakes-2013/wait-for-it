class Restaurant < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :reservations

  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  has_secure_password
end
