class AddUserIdToCompanionAdvertisements < ActiveRecord::Migration
  def self.up
	add_column :companion_advertisements, :user_id, :integer, :nil => false
  end

  def self.down
	remove_column :companion_advertisements, :user_id
  end
end
