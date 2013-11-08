class ApplicationController < ActionController::Base
	protect_from_forgery

	private

	def current_restaurant
		@current_restaurant ||= Restaurant.find(session[:restaurant_id]) if session[:restaurant_id]
	end

	helper_method :current_restaurant

end
