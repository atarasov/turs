class CreateRewards < ActiveRecord::Migration
  def self.up
    create_table :rewards do |t|
      t.string :title
      t.integer :user_id

      t.string :image_file_name
      t.string :image_content_type
      t.string :image_file_size
      t.string :image_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :rewards
  end
end
