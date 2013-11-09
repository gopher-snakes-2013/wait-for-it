class SessionsController < ApplicationController

	def create
		restaurant = Restaurant.find_by_email(params[:email])
		if restaurant && restaurant.authenticate(params[:password]) 
			session[:restaurant_id] = restaurant.id
			redirect_to root_path
		else
			flash[:error] = "Try Again!"
      redirect_to restaurants_path
		end
	end

	def destroy
		session.clear
		redirect_to restaurants_path
	end

end
