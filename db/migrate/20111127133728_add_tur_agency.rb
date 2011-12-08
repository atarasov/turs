class AddTurAgency < ActiveRecord::Migration
  def self.up
    add_column :users, :is_tour_agency, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_tour_agency
  end
end
