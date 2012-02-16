class AddIsPriorityToDirections < ActiveRecord::Migration
  def self.up
	add_column :directions, :is_priority, :boolean, :nil => false, :default => false
  end

  def self.down
	remove_column :directions, :is_priority
  end
end
