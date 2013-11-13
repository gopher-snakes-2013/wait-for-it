class RemoveMaxWaitTimeFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :max_wait_time
  end
end
