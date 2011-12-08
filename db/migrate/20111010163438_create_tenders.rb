class CreateTenders < ActiveRecord::Migration
  def self.up
    create_table :tenders do |t|
      t.string :name
      t.integer :type_of_holiday
      t.integer :catalog_id
      t.integer :country_id
      t.integer :city_id
      t.date :start_date
      t.integer :budget
      t.text :description
      t.boolean :turs
      t.text :contacts

      t.timestamps
    end
  end

  def self.down
    drop_table :tenders
  end
end
