class ReservationsController < ApplicationController

	def index
    if current_restaurant
      @restaurant = Restaurant.find(current_restaurant.id)
      @reservations = Reservation.where(restaurant_id: @restaurant.id).order("wait_time ASC")
      @reservation = @restaurant.reservations.new
    else
      redirect_to root_path
    end

    @time = DateTime.now.strftime("%b %e, %Y %l:%M %P")
  end

  def create
    puts "reservation#create"
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
    puts "reservation#create#end"

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
      render json: { name: reservation.name,
                     party_size: reservation.party_size,
                     phone_number: reservation.phone_number.phony_formatted(normalize: :US, format: :national, spaces: '-'),
                     wait_time: reservation.wait_time_display,
                     status: reservation.status,
                     estimated_seat_time: reservation.estimated_seat_time_display }.to_json
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


  def guest
  end

  respond_to :json
  def api
    restaurant = Restaurant.find_by_name(params[:restaurant_name])
    reservations = Reservation.where("restaurant_id = ?", restaurant.id)
    render json: {reservations: reservations}.to_json
  end

  def seat_times
    estimated_seat_times = {}
    current_reservations = params[:reservations_on_page].map { |reservation_id| Reservation.find(reservation_id)}
    current_reservations.each {|reservation| estimated_seat_times[reservation.id] = { seat_time: reservation.estimated_seat_time_display,status: reservation.status }}
    render json: {estimated_seat_times: estimated_seat_times}.to_json
  end

  def currentreservations
    current_reservations = Reservation.where("restaurant_id = ?",params[:current_restaurant])
    current_reservations = current_reservations.reject { |reservation| reservation.estimated_seat_time < (Time.now - 30*60) }
    current_reservations = current_reservations.reject { |reservation| reservation.status == "Archived"}
    current_reservations = current_reservations.sort_by { |reservation| reservation.estimated_seat_time}
    render json: {reservations: current_reservations}.to_json
  end
end
