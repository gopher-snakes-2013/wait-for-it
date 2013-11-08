class ReservationsController < ApplicationController

	def index
    @reservations = Reservation.all
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
	end

	def destroy
	end

end