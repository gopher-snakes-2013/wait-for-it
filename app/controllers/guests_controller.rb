class GuestsController < ApplicationController
  before_filter :redirect_to_reservation, :only => [:index]
  before_filter :redirect_to_guest, :only => [:index]

  def index
  end

  def new
    @guest = Guest.new
  end

  def create
    guest = Guest.new(params[:guest])
    if guest.save
      login_guest(guest)
      redirect_to guest_path(guest)
    else
      render :new
    end
  end

  def restaurants
    @restaurants = Restaurant.all
    @restaurant = Restaurant.new
    @reservation = Reservation.new
  end

  def show
    @guest = Guest.find(params[:id])
  end

  private

  def redirect_to_reservation
    redirect_to restaurant_reservations_path(current_restaurant) if logged_in?
  end

  def redirect_to_guest
    redirect_to guest_restaurants_path(current_guest) if guest_logged_in?
  end

end
