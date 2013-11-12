class AddUniqueKeyColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :unique_key, :string
  end
end
