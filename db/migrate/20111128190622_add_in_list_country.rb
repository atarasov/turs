class AddInListCountry < ActiveRecord::Migration
  def self.up
    add_column :countries, :in_list, :boolean, :default => true;
  end

  def self.down
    remove_column :countries, :in_list
  end
end
