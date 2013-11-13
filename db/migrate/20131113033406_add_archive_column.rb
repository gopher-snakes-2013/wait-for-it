class AddArchiveColumn < ActiveRecord::Migration
  def up
  	add_column :reservations, :archived, :boolean, :default => "false"
  end

  def down
  	drop_column :reservations, :archived
  end
end
