class AddRoles < ActiveRecord::Migration
  def self.up
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :is_company, :boolean, :default => false
    add_column :users, :is_guest, :boolean, :default => true
  end

  def self.down
    remove_column :users, :is_admin
    remove_column :users, :is_company
    remove_column :users, :is_guest
  end
end
