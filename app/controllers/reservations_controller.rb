class ReservationsController < ApplicationController

	def index
    if current_restaurant
      @restaurant = Restaurant.find(current_restaurant.id)
      @reservations = Reservation.where(restaurant_id: @restaurant.id)
      @reservation = @restaurant.reservations.new
    else
      redirect_to root_path
    end
	end

	def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.new
    if @reservation.save
      render text: render_to_string(partial: 'reservations/show', layout: false, locals: { reservation: @reservation })
    else
      render status: :unprocessable_entity, json: { error_message: "Try Again." }.to_json
    end
	end

  def update
  	@reservation = Reservation.find(params[:id])
  	if @reservation.update_attributes(params[:reservation])
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

  respond_to :json
  def api
    reservations = Reservation.find_by_restaurant_id(params[:restaurant_id])
    render json: {reservations: reservations}.to_json 
  end

end