class AddUserCurd < ActiveRecord::Migration
  def self.up
    add_column :users, :coord_long, :string
    add_column :users, :coord_lat, :string
  end

  def self.down
    remove_column :users, :coord_long
    remove_column :users, :coord_lat
  end
end
