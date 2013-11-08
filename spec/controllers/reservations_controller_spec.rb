require 'spec_helper'

describe ReservationsController do
	let!(:reservation) {
		Reservation.create name: 'George', party_size: 4, phone_number: '555-555-5555'
	}
	
	describe '#update' do
		it 'should result in an updated name field' do
			put :update, id: reservation.id, reservation: {name: 'john'}
			expect(Reservation.find(reservation.id).name).to eq('john')
		end

	end

	describe '#destroy' do
		it 'should delete specified record' do
			expect { delete :destroy, id: reservation.id }.to change { Reservation.count }.by(-1)
		end
	end

  it "#index" do
    get :index
    response.status.should eq(200)
  end

  context "#create" do
    it "should add a valid reservation to the db" do
      expect {
        post :create, reservation: {name: "Nat", party_size: 4, phone_number: '650-500-5000', wait_time: 15 }
      }.to change { Reservation.count }.by 1
    end

    it "should NOT add an invalid reservation to the db" do
      expect {
        post :create, reservation: { name: nil, party_size: nil, phone_number: nil }
      }.to_not change { Reservation.count }
    end
  end

end