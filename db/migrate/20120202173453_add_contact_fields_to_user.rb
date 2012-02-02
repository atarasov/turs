class AddContactFieldsToUser < ActiveRecord::Migration
  def self.up
	add_column :users, :icq, :string
	add_column :users, :skype, :string
  end

  def self.down
	remove_column :users, :icq
	remove_column :users, :skype
  end
end
