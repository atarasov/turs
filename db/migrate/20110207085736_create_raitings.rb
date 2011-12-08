class CreateRaitings < ActiveRecord::Migration
  def self.up
    create_table :raitings do |t|
      t.integer :count
      t.integer :user_id
      t.integer :country_id
      t.integer :journal_id

      t.timestamps
    end
  end

  def self.down
    drop_table :raitings
  end
end
