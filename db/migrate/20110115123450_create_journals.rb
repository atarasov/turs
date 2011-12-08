class CreateJournals < ActiveRecord::Migration
  def self.up
    create_table :journals do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :category_id
      t.string :title
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :journals
  end
end
