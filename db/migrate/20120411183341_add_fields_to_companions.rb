class AddFieldsToCompanions < ActiveRecord::Migration
  def self.up
	add_column :companion_advertisements, :start_date, :date
	add_column :companion_advertisements, :end_date, :date
	add_column :companion_advertisements, :sponsor, :boolean
  end

  def self.down
	remove_column :companion_advertisements, :start_date
	remove_column :companion_advertisements, :end_date
	remove_column :companion_advertisements, :sponsor
  end
end
