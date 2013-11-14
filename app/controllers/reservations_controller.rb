class ReservationsController < ApplicationController
  before_filter :authenticate_restaurant, :only => [:index]
  before_filter :authenticate_guest, :only => [:show]
  before_filter :load_restaurant, :except => [:index, :guest, :seat_times, :currentreservations, :messages]
  before_filter :load_reservation, :only => [:show, :update, :destroy, :messages, :archive]

	def index
    @reservations = current_restaurant.current_reservations
    @reservation = current_restaurant.reservations.new
  end

  def create
    reservation = @restaurant.reservations.new params[:reservation]
    if reservation.save
      render text: render_to_string(partial: 'reservations/show', layout: false, locals: { restaurant: @restaurant, reservation: reservation })
    else
      render json: { error_message: reservation.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
  	if @reservation.update_attributes(params[:reservation])
      render json: @reservation.as_json
    else
      render status: :unprocessable_entity, json: {:errors => @reservation.errors.full_messages.join(", ")}
    end
  end

  def destroy
  	@reservation.destroy
  	redirect_to restaurant_reservations_path(@restaurant)
  end

  def archive
    @reservation.archive!
    @reservation.save
    redirect_to restaurant_reservations_path(@restaurant)
  end

  def currentreservations
    render json: { reservations: current_restaurant.current_reservations }
  end

  def messages
    @reservation.send_text_table_ready
    render json: {reservation: @reservation}
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

  def load_reservation
    @reservation = Reservation.find(params[:id])
  end
end
