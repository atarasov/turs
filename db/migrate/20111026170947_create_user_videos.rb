class CreateUserVideos < ActiveRecord::Migration
  def self.up
    create_table :user_videos do |t|
      t.string :title
      t.integer :user_id

      t.string :video_file_name
      t.string :video_content_type
      t.string :video_file_size
      t.string :video_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_videos
  end
end
