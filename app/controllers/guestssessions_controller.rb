class GuestssessionsController < ApplicationController

  def create
    guest = Guest.find_by_email(params[:email])
    if guest && guest.authenticate(params[:password])
      login_guest(guest)
      redirect_to guest_restaurants_path(guest)
    else
      flash[:error] = "Invalid username/password combination"
      render 'restaurants/index'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end