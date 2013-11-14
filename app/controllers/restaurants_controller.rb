class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all.sort_by {|restaurant| restaurant.max_wait_time }
    render text: render_to_string(file: 'restaurants/index', layout: false, locals: { restaurants: @restaurants })
  end

  def new
    @restaurant = Restaurant.new
    render text: render_to_string(file: 'restaurants/new', layout: false, locals: { restaurant: @restaurant })
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    if @restaurant.save
      login(@restaurant)
      redirect_to restaurant_reservations_path(@restaurant)
    else
      render :new
    end
  end
end