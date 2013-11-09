class AddNotifiedTableReadyToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :notified_table_ready, :boolean
  end
end
