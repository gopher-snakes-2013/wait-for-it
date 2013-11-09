class ReservationsController < ApplicationController

	def index
    @reservations = Reservation.order(:wait_time)
    @reservation = Reservation.new
	end

	def create
    @reservation = Reservation.new(params[:reservation])
    if @reservation.save
      redirect_to root_path
    else
      flash[:error] = "Try Again."
      redirect_to root_path
    end
	end

  def update
  	@reservation = Reservation.find(params[:id])
  	if @reservation.update_attributes(params[:reservation])
    	redirect_to root_path
    else
      flash[:error] = "Try Updating Again."
      redirect_to root_path
    end
  end

  def destroy
  	@reservation = Reservation.find(params[:id])
  	@reservation.destroy
  	redirect_to root_path
  end
end