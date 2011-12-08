class CreateMemos < ActiveRecord::Migration
  def self.up
    create_table :memos do |t|
      t.text :description
      t.text :about
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :memos
  end
end
