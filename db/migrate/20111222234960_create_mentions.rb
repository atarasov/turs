class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions do |t|
	  t.string :title, :nil => false, :default => ""
	  t.string :text, :nil => false, :default => ""
	  t.string :name, :nil => false, :default => ""
	  t.string :page_url, :nil => false, :default => ""
	  t.string :avatar_file_name
	  t.string :avatar_content_type
	  t.integer :avatar_file_size
	  t.datetime :avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :mentions
  end
end
