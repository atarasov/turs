class CreateCommands < ActiveRecord::Migration
  def self.up
    create_table :commands do |t|
	  t.integer :leader_id, :nil => false, :default => 0
	  t.integer :member_id, :nil => false, :default => 0
	  t.boolean :is_confirmed, :nil => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :commands
  end
end
