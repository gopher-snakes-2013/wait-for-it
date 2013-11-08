class ReservationsController < ApplicationController

	def create
    @reservation = Reservation.new(params[:reservation])
    if @reservation.save
      redirect_to root_path
    else
      flash[:error] = "Try Again."
      redirect_to root_path
    end
	end

	def index
    @reservations = Reservation.all
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