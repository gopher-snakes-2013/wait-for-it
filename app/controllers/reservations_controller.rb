class ReservationsController < ApplicationController

	def index
    if current_restaurant
      @restaurant = Restaurant.find(current_restaurant.id)
      @reservations = Reservation.where(restaurant_id: @restaurant.id).order("wait_time ASC")
      @reservation = @restaurant.reservations.new
    else
      redirect_to root_path
    end
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    reservation = restaurant.reservations.new
    reservation.name = params[:reservation][:name]
    reservation.party_size = params[:reservation][:party_size]
    reservation.phone_number = params[:reservation][:phone_number]
    reservation.wait_time = params[:reservation][:wait_time]
    reservation.before_wait_time = params[:reservation][:wait_time]
    if reservation.save
      render text: render_to_string(partial: 'reservations/show', layout: false, locals: { restaurant: restaurant, reservation: reservation })
    else
      render status: :unprocessable_entity, json: { error_message: "Try Again." }.to_json
    end
  end

  def show
    if guest_access
      @restaurant = Restaurant.find(params[:restaurant_id])
      @reservation = Reservation.find(params[:id])
      @reservations = Reservation.where(restaurant_id: @restaurant.id).order("wait_time ASC")
    else
      redirect_to root_path
    end
  end

  def update
    restaurant = Restaurant.find(params[:restaurant_id])
    reservation = Reservation.find(params[:id])
  	if reservation.update_attributes(params[:reservation])
      session[:restaurant_id] = restaurant.id
      render json: { name: params[:reservation][:name],
                     party_size: params[:reservation][:party_size],
                     phone_number: params[:reservation][:phone_number],
                     wait_time: params[:reservation][:wait_time] }.to_json
    else
      session[:restaurant_id] = restaurant.id
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

  def update_wait_time
    wait_times = {}

    restaurant = Restaurant.find(params[:restaurant_id])
    reservations = restaurant.reservations
    number_of_reservations = reservations.length
    wait_times[:total] = number_of_reservations

    Reservation.order("wait_time").each do |reservation|
      if reservation.wait_time > 0
        reservation.wait_time = reservation.wait_time - 1
        reservation.save
        wait_times[reservation.id] = {}
        wait_times[reservation.id][:minutes] = reservation.wait_time
        wait_times[reservation.id][:done] = false
      elsif reservation.wait_time <= 0
        reservation.wait_time = 0
        reservation.save
        wait_times[reservation.id] = {}
        wait_times[reservation.id][:minutes] = reservation.wait_time
        wait_times[reservation.id][:done] = true
      end
    end

    render json: wait_times.to_json
  end
end
