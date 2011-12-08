class AddFildsProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :raiting, :integer, :default => 0
    add_column :profiles, :is_recomended, :boolean, :default => false
  end

  def self.down
    remove_column :profiles, :raiting
    remove_column :profiles, :is_recomended
  end
end
