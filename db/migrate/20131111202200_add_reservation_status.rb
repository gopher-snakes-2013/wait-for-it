class AddReservationStatus < ActiveRecord::Migration
  def up
  	add_column :reservations, :status, :string, :default => 'Waiting'
  end

  def down
  	drop_column :reservations, :status
  end
end
