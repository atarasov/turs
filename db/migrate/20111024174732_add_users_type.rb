class AddUsersType < ActiveRecord::Migration
  def self.up
     add_column :users, :is_hotel, :boolean, :default => false
     add_column :users, :is_tour_operator, :boolean, :default => false
     add_column :users, :is_recreation_center, :boolean, :default => false
     add_column :users, :is_sanatorium, :boolean, :default => false
     add_column :users, :is_hostel, :boolean, :default => false
     add_column :users, :is_guide, :boolean, :default => false
     add_column :users, :is_taxi, :boolean, :default => false
     add_column :users, :is_mini_hotel, :boolean, :default => false
     add_column :users, :is_user, :boolean, :default => true
  end

  def self.down
     remove_column :users, :is_hotel
     remove_column :users, :is_tour_operator
     remove_column :users, :is_recreation_center
     remove_column :users, :is_sanatorium
     remove_column :users, :is_hostel
     remove_column :users, :is_guide
     remove_column :users, :is_taxi
     remove_column :users, :is_mini_hotel
     remove_column :users, :is_user
  end
end
