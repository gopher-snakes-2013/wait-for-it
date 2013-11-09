class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant = Restaurant.new(params[:restaurant])
    if restaurant.save
      session[:restaurant_id] = restaurant.id
      redirect_to restaurant_reservations_path(session[:restaurant_id])
    else
      flash[:error] = "Try Again!"
      redirect_to new_restaurant_path
    end
  end

end