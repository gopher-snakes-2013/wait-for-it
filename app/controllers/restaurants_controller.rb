class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|
      restaurant.update_max_wait_time
    end
  end

  def new
    @restaurant = Restaurant.new
    render text: render_to_string(file: 'restaurants/new', layout: false, locals: { restaurant: @restaurant })
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
