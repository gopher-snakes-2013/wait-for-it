require 'spec_helper'

describe RestaurantsController do
  let!(:restaurant) {
    Restaurant.create name: 'Kitchen', email: 'kitchen@mail.com', password: 'password', password_confirmation: 'password'
  }

  it "#index" do
    get :index
    response.status.should eq(200)
  end

  it "#new" do
    get :new
    response.status.should eq(200)
  end

  context "#create" do
    it "should add a valid restaurant to the db" do
      expect {
        post :create, restaurant: {name: "Kitchen", email: "kitchen@mail.com", password: "password", password_confirmation: "password" }
      }.to change { Restaurant.count }.by 1
    end

    it "should NOT add an invalid restaurant to the db" do
      expect {
        post :create, restaurant: {name: "Kitchen", password: "password"}
      }.to_not change { Restaurant.count }
    end
  end

end
