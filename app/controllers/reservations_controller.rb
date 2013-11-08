class ReservationsController < ApplicationController

  def index
  	@reservations = Reservation.all
  end

  def create
  	@reservation = Reservation.new
  end

  def update
  	@reservation = Reservation.find(params[:id])
  	
  	@reservation.update_attributes params[:reservation]
  	redirect_to root_path
  end

  def destroy
  	@reservation = Reservation.find(params[:id])
  	@reservation.destroy
  	redirect_to root_path
  end
end