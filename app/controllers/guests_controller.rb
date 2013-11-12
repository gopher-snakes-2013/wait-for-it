class GuestsController < ApplicationController

  def index
    if logged_in?
      redirect_to restaurant_reservations_path(current_restaurant.id)
    end
  end

end