class CreateStends < ActiveRecord::Migration
  def self.up
    create_table :stends do |t|
      t.integer :country_id
      t.integer :user_id
      t.integer :days
      t.string :price

      t.timestamps
    end
  end

  def self.down
    drop_table :stends
  end
end
