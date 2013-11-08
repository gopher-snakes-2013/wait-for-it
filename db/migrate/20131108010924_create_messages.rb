class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :phone_number
      t.belongs_to :reservation

      t.timestamps
    end
  end

end
