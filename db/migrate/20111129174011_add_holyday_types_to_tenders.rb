class AddHolydayTypesToTenders < ActiveRecord::Migration
  def self.up
	add_column :tenders, :is_beach, :boolean, :nil => false, :default => false
	add_column :tenders, :is_exotic, :boolean, :nil => false, :default => false
	add_column :tenders, :is_therapeutic, :boolean, :nil => false, :default => false
	add_column :tenders, :is_ski, :boolean, :nil => false, :default => false
	add_column :tenders, :is_religious, :boolean, :nil => false, :default => false
	add_column :tenders, :is_business, :boolean, :nil => false, :default => false
	add_column :tenders, :is_cruise, :boolean, :nil => false, :default => false
	add_column :tenders, :is_extreme, :boolean, :nil => false, :default => false
	add_column :tenders, :is_event, :boolean, :nil => false, :default => false
  end

  def self.down
	remove_column :tenders, :is_beach
	remove_column :tenders, :is_exotic
	remove_column :tenders, :is_therapeutic
	remove_column :tenders, :is_ski
	remove_column :tenders, :is_religious
	remove_column :tenders, :is_business
	remove_column :tenders, :is_cruise
	remove_column :tenders, :is_extreme
	remove_column :tenders, :is_event
  end
end
