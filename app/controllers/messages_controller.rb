# JEFF! :)
# this controller is unnecessary.
# reservation update should happen on reservations_controller :update.
# on the reservation model, add a before_udpate to notify_table_ready and to call Twillio
class MessagesController < ApplicationController
  respond_to :json

  def create
    reservation = Reservation.find(params[:guest_id])
    reservation.notified_table_ready = true
    reservation.save
    TwilioHelper.table_ready(reservation.phone_number)
    render json: {reservation: reservation}.to_json
  end
end
