class AddFilds < ActiveRecord::Migration
  def self.up
    add_column :profiles, :review, :integer, :default => 1
  end

  def self.down
    remove_column :profiles, :review
  end
end
