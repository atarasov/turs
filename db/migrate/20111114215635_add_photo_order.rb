class AddPhotoOrder < ActiveRecord::Migration
  def self.up
    add_column :photos, :order, :integer, :default => 0
  end

  def self.down
    remove_column :photos, :order
  end
end
