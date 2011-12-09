class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.integer :referee_id, :nil => false, :default => 0
      t.integer :recommended_user_id, :nil => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :recommendations
  end
end
