class ApplicationController < ActionController::Base
	protect_from_forgery
	helper_method :current_restaurant, :logged_in?

  def current_restaurant
    @current_restaurant ||= Restaurant.find(session[:restaurant_id]) if session[:restaurant_id]
  end

  def logged_in?
    !!current_restaurant
  end

end
