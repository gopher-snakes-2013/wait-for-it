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
      redirect_to guest_restaurants_path(guest)
    else
      render :new
    end
  end

  def restaurants
    @restaurants = Restaurant.all
    @guest = Guest.find(params[:id])
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def reservation_request
    guest = Guest.find(params[:id])
    restaurant = Restaurant.find(params[:restaurant_id])
    reservation = restaurant.reservations.new(params[:reservation])
    reservation.guest_id = guest.id
    if reservation.save
      render json: { text: "Your reservation request has been sent. You'll recieve a confirmation text shortly."}
    else
      render status: :unprocessable_entity, json: { simple_error: "Please try again." ,error_messages: reservation.errors.full_messages.join(", ") }.to_json
    end
  end

  private

  def redirect_to_reservation
    redirect_to restaurant_reservations_path(current_restaurant) if logged_in?
  end

  def redirect_to_guest
    redirect_to guest_restaurants_path(current_guest) if guest_logged_in?
  end

end
