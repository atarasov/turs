class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :phone
      t.string :email
      t.string :addr
      t.text   :about_text
      t.string :meta_title
      t.text   :meta_description
      t.string :meta_keywords
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
