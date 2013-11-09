class RestaurantsController < ApplicationController

	def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    if @restaurant.save
      redirect_to root_path
    else
      flash[:error] = "Try Again!"
      redirect_to new_restaurant_path
    end
	end

  def index
    @restaurants = Restaurant.all
  end

end