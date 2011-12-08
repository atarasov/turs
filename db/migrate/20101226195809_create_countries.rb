class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :title
      t.text :description
      t.text :meta
      t.text :keywords

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
