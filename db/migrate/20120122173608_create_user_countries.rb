class CreateUserCountries < ActiveRecord::Migration
  def self.up
    create_table :user_countries do |t|
      t.integer :country_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_countries
  end
end
