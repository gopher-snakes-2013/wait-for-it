class UpdateReservationStatus < ActiveRecord::Migration
  def up
  	change_column :reservations, :status, :string, :default => 'Waiting'
  end

  def down
  	change_column :reservations, :status, :string, :default => 'Waiting'
  end
end
