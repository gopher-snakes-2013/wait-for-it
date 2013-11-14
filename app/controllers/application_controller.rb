class ApplicationController < ActionController::Base
	protect_from_forgery
	helper_method :current_restaurant, :logged_in?, :guest_logged_in?, :current_guest

  def current_restaurant
    @current_restaurant ||= Restaurant.find(session[:restaurant_id]) if session[:restaurant_id]
  end

  def logged_in?
    !!current_restaurant
  end

  def login_restaurant restaurant
    session[:restaurant_id] = restaurant.id
  end

  def current_guest
    @current_guest ||= Guest.find(session[:guest_id]) if session[:guest_id]
  end

  def guest_logged_in?
    !!current_guest
  end

  def login_guest guest
    session[:guest_id] = guest.id
  end

  def guest_access
    reservation = Reservation.find(params[:id])
    guest_key == reservation.unique_key
  end

  def guest_key
    params[:guest]
  end
end