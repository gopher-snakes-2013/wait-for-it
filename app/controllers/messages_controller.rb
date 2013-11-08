class MessagesController < ApplicationController
  respond_to :json
  def new
    "stuff"
  end


  def create
    reservation = Reservation.find(params[:guest_id])
    TwilioHelper.table_ready(reservation.phone_number)
    render json: {reservation: reservation}.to_json
  end
end