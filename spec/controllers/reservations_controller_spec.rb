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
end