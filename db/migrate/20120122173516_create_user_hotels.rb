class CreateUserHotels < ActiveRecord::Migration
  def self.up
    create_table :user_hotels do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_hotels
  end
end
