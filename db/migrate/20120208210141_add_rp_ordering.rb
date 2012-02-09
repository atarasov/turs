class AddRpOrdering < ActiveRecord::Migration
  def self.up
    add_column :report_photos, :order, :integer, :default => 0
  end

  def self.down
    remove_column :report_photos, :order
  end
end
