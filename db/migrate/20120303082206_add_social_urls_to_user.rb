class AddSocialUrlsToUser < ActiveRecord::Migration
  def self.up
	  add_column :users, :classmates_url, :string
	  add_column :users, :google_buzz_url, :string
	  add_column :users, :my_mail_url, :string
	  add_column :users, :ya_ru_url, :string
  end

  def self.down
	  remove_column :users, :classmates_url
	  remove_column :users, :google_buzz_url
	  remove_column :users, :my_mail_url
	  remove_column :users, :ya_ru_url
  end
end
