class ReservationsController < ApplicationController

	def index
    if current_restaurant
      @restaurant = Restaurant.find(current_restaurant.id)
      @reservations = Reservation.where(restaurant_id: @restaurant.id)
      @reservation = @restaurant.reservations.new
    else
      redirect_to restaurant_reservations_path(@restaurant.id)
    end
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    reservation = restaurant.reservations.new
    reservation.name = params[:reservation][:name]
    reservation.party_size = params[:reservation][:party_size]
    reservation.phone_number = params[:reservation][:phone_number]
    reservation.wait_time = params[:reservation][:wait_time]
    if reservation.save
      render text: render_to_string(partial: 'reservations/show', layout: false, locals: { restaurant: restaurant, reservation: reservation })
    else
      render status: :unprocessable_entity, json: { error_message: "Try Again." }.to_json
    end
	end

  def update
    restaurant = Restaurant.find(params[:restaurant_id])
  	reservation = Reservation.find(params[:id])
  	if reservation.update_attributes(params[:reservation])
      redirect_to restaurant_reservations_path(restaurant.id)
    else
      flash[:error] = "Try Updating Again."
      redirect_to restaurant_reservations_path(restaurant.id)
    end
  end

  def destroy
    restaurant = Restaurant.find(params[:restaurant_id])
  	reservation = Reservation.find(params[:id])
  	reservation.destroy
  	redirect_to restaurant_reservations_path(restaurant.id)
  end

  def guest
  end

  respond_to :json
  def api
    restaurant = Restaurant.find_by_name(params[:restaurant_name])
    reservations = Reservation.where("restaurant_id = ?", restaurant.id)
    render json: {reservations: reservations}.to_json
  end
end
