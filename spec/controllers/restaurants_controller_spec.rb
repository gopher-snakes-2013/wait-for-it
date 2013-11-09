require 'spec_helper'

describe RestaurantsController do

  context "#create" do
    it "should add a valid restaurant to the db" do
      expect {
        post :create, restaurant: {name: 'Daisys', email: 'daisy@mail.com', password: 'password', password_confirmation: 'password' }
      }.to change { Restaurant.count }.by 1
    end

  end

end
