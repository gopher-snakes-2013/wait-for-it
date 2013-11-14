class AddConfirmedColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :confirmed, :boolean, default: false
  end
end
