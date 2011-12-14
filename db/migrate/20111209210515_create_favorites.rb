class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.integer :user_id, :nil => false, :default => 0
      t.integer :favorite_id, :nil => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
