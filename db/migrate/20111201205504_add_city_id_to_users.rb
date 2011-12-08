class AddCityIdToUsers < ActiveRecord::Migration
  def self.up
	add_column :users, :city_id, :integer, :nil => false, :default => 0
  end

  def self.down
	remove_column :users, :city_id
  end
end
