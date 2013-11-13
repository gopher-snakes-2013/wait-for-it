class ReservationsController < ApplicationController
  before_filter :authenticate_restaurant, :only => [:index]
  before_filter :authenticate_guest, :only => [:show]
  before_filter :load_restaurant, :except => [:index, :guest, :seat_times, :currentreservations]

	def index
    @reservations = current_restaurant.reservations.order("wait_time ASC")
    @reservation = current_restaurant.reservations.new
  end

  def create
    reservation = @restaurant.reservations.new params[:reservation]
    if reservation.save
      render text: render_to_string(partial: 'reservations/show', layout: false, locals: { restaurant: @restaurant, reservation: reservation })
    else
      render status: :unprocessable_entity, json: { error_message: reservation.errors.full_messages.join(", ") }.to_json
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @reservations = Reservation.where(restaurant_id: @restaurant.id).order("wait_time ASC")
  end

  def update
    reservation = Reservation.find(params[:id])
  	if reservation.update_attributes(params[:reservation])
      render json: reservation.as_json
    else
      render status: :unprocessable_entity, json: {:errors => reservation.errors.full_messages.join(", ")}
    end
  end

  def destroy
  	reservation = Reservation.find(params[:id])
  	reservation.destroy
  	redirect_to restaurant_reservations_path(@restaurant)
  end

  # def archive!
    #Laura!  (archive default to false; add archive column. when you click on x switch to archive is true.)
  # end

  # def archive?
  # end

  def currentreservations
    render json: { reservations: current_restaurant.current_reservations }
  end

  private
  def authenticate_restaurant
    redirect_to root_path unless logged_in?
  end

  def authenticate_guest
    redirect_to root_path unless guest_access
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
