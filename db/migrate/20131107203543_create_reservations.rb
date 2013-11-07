class CreateReservations < ActiveRecord::Migration
  def up
  	create_table :reservations do |t|
  		t.string :name
  		t.integer :party_size
  		t.string :phone_number
  		t.integer :wait_time
  		t.timestamps
  	end
  end

  def down
  	drop_table :reservations
  end
end
