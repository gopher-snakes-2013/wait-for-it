class CreateGuestsTable < ActiveRecord::Migration
  def up
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end

  def down
    drop_table :guests
  end
end
