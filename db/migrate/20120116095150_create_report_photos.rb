class CreateReportPhotos < ActiveRecord::Migration
  def self.up
    create_table :report_photos do |t|
      t.string :title
      t.text :description

      t.string :news, :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.integer :report_id
      t.timestamps
    end
  end

  def self.down
    drop_table :report_photos
  end
end
