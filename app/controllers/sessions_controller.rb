class SessionsController < ApplicationController

	def create
		restaurant = Restaurant.find_by_email(params[:email])
		if restaurant && restaurant.authenticate(params[:password])
			login(restaurant)
			redirect_to restaurant_reservations_path(restaurant)
		else
			flash[:error] = "Invalid username/password combination"
      redirect_to root_path
		end
	end

	def destroy
		session.clear
		redirect_to root_path
	end
end