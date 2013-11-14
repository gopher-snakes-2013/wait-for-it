class Guest < ActiveRecord::Base
  attr_accessible :name, :email, :phone_number, :password, :password_confirmation
  has_many :reservations
  has_secure_password

  validates_presence_of :password, on: :create
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([\w\!\#\z\%\&\'\*\+\-\/\=\?\\A\`{\|\}\~]+\.)*[\w\+-]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)\z/i, on: :create

  phony_normalize :phone_number, :default_country_code => 'US'
  validates_plausible_phone :phone_number, :presence => true, :country_code => '1'
end