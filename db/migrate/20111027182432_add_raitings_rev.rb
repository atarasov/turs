class AddRaitingsRev < ActiveRecord::Migration
  def self.up
    add_column :countries, :review, :integer, :default => 0
    add_column :countries, :rating, :integer, :default => 0
    add_column :journals, :recomended, :boolean, :default => false
  end

  def self.down
    remove_column :countries, :review
    remove_column :countries, :rating
    remove_column :journals, :recomended
  end
end
