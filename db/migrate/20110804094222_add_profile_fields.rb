class AddProfileFields < ActiveRecord::Migration
  def self.up
    add_column :profiles, :name, :string
    
  end

  def self.down
    remove_column :profiles, :name
  end
end
