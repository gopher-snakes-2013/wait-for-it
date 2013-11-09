class AddEstimatedSeatTimeColumn < ActiveRecord::Migration
  def up
    add_column :reservations, :estimated_seat_time, :datetime
  end

  def down
    remove_column :reservations, :estimated_seat_time, :datetime
  end
end
