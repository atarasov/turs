class CreateCompanionAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :companion_advertisements do |t|
      t.string :title, :nil => false, :default => ""
      t.integer :days, :nil => false, :default => 1
      t.integer :from_city
      t.string :where, :nil => false, :default => ""
	  t.string :description, :nil => false, :default => ""
	  t.integer :author_type, :nil => false, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :companion_advertisements
  end
end
