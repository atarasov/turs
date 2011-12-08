class AddRequestTypeToCompanionAdvertisements < ActiveRecord::Migration
  def self.up
	add_column :companion_advertisements, :request_type, :integer, :nil => false
  end

  def self.down
	remove_column :companion_advertisements, :request_type
  end
end
