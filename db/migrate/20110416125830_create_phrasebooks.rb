class CreatePhrasebooks < ActiveRecord::Migration
  def self.up
    create_table :phrasebooks do |t|
      t.text :description
      t.text :about
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :phrasebooks
  end
end
