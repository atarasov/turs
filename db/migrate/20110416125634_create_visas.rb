class CreateVisas < ActiveRecord::Migration
  def self.up
    create_table :visas do |t|
      t.text :description
      t.text :about
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :visas
  end
end
