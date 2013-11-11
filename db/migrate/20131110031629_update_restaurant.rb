class UpdateRestaurant < ActiveRecord::Migration
  def up
  	add_column :restaurants, :max_wait_time, :integer
  end

  def down
  	remove_column :restaurants, :max_wait_time
  end
end
