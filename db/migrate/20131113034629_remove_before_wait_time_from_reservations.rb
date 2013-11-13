class RemoveBeforeWaitTimeFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :before_wait_time
  end
end
