class GuestsController < ApplicationController
  before_filter :redirect_to_reservation, :only => [:index]

  def index
  end

  private

  def redirect_to_reservation
    redirect_to restaurant_reservations_path(current_restaurant) if logged_in?
  end

end
