class CreateTurs < ActiveRecord::Migration
  def self.up
    create_table :turs do |t|
      t.string :title
      t.integer :stars
      t.integer :price
      t.integer :user_id
      t.integer :country_id
      t.boolean :is_recomended
      t.text :description

      t.string :image_file_name
      t.string :image_content_type
      t.string :image_file_size
      t.string :image_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :turs
  end
end
