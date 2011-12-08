class CreateDirections < ActiveRecord::Migration
  def self.up
    create_table :directions do |t|
      t.integer :country_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :directions
  end
end
