class SessionsController < ApplicationController

	def create
		restaurant = Restaurant.find_by_email(params[:email])
		if restaurant && restaurant.authenticate(params[:password])
			session[:restaurant_id] = restaurant.id
			redirect_to restaurant_reservations_path(session[:restaurant_id])
		else
			flash[:error] = "Try Again!"
      redirect_to root_path
		end
	end

	def destroy
		session.clear
		redirect_to root_path
	end

end
