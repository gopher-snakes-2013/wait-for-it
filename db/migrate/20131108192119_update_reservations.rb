class UpdateReservations < ActiveRecord::Migration
  def up
  	add_column :reservations, :restaurant_id, :integer
  end

  def down
  	remove_column :reservations, :restaurant_id
  end
end
