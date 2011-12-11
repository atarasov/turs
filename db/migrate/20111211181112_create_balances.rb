class CreateBalances < ActiveRecord::Migration
  def self.up
    create_table :balances do |t|
      t.float :sum, :nil => false, :default => 0.0
      t.integer :user_id, :nil => false
      t.boolean :is_ingoing, :nil => false
      t.boolean :is_confirmed, :nil => false, :default => false
	  t.string :comment, :nil => false, :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :balances
  end
end
