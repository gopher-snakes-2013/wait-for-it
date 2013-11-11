class AddBeforeWaitTimeColumnReservations < ActiveRecord::Migration
  def up
    add_column :reservations, :before_wait_time, :integer
  end

  def down
    drop_column :reservations, :before_wait_time
  end
end
