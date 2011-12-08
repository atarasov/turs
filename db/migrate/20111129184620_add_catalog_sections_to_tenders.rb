class AddCatalogSectionsToTenders < ActiveRecord::Migration
  def self.up
	add_column :tenders, :is_agent, :boolean, :nil => false, :default => false
	add_column :tenders, :is_sanatorium, :boolean, :nil => false, :default => false
	add_column :tenders, :is_hotel, :boolean, :nil => false, :default => false
	add_column :tenders, :is_tour_operator, :boolean, :nil => false, :default => false
	add_column :tenders, :is_recreation_center, :boolean, :nil => false, :default => false
	add_column :tenders, :is_mini_hotel, :boolean, :nil => false, :default => false
	add_column :tenders, :is_guesthouse, :boolean, :nil => false, :default => false
	add_column :tenders, :is_taxi, :boolean, :nil => false, :default => false
	add_column :tenders, :is_guide, :boolean, :nil => false, :default => false
  end

  def self.down
	remove_column :tenders, :is_agent
	remove_column :tenders, :is_sanatorium
	remove_column :tenders, :is_hotel
	remove_column :tenders, :is_tour_operator
	remove_column :tenders, :is_recreation_center
	remove_column :tenders, :is_mini_hotel
	remove_column :tenders, :is_guesthouse
	remove_column :tenders, :is_taxi
	remove_column :tenders, :is_guide
  end
end
