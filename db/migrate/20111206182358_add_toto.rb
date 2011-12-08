class AddToto < ActiveRecord::Migration
  def self.up
    drop_table :companion_advertisements
    create_table :companion_advertisements do |t|
      t.string :title, :nil => false, :default => ""
      t.integer :days, :nil => false, :default => 1
      t.integer :from_city
      t.string :where, :nil => false, :default => ""
	  t.string :description, :nil => false, :default => ""
	  t.integer :author_type, :nil => false, :default => 1

      t.timestamps
    end
    add_column :companion_advertisements, :user_id, :integer, :nil => false
  end

  def self.down
    drop_table :companion_advertisements
  end
end
