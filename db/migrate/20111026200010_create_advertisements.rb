class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements do |t|
      t.integer :price
      t.date :expire_date
      t.text :description
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
