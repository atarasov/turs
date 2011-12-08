class AddContactFieldsToTenders < ActiveRecord::Migration
  def self.up
	add_column :tenders, :contact_email, :string, :nil => false, :default => ""
	add_column :tenders, :contact_icq, :string, :nil => false, :default => ""
	add_column :tenders, :contact_phone, :string, :nil => false, :default => ""
	add_column :tenders, :contact_skype, :string, :nil => false, :default => ""
  end

  def self.down
	remove_column :tenders, :contact_email
	remove_column :tenders, :contact_icq
	remove_column :tenders, :contact_phone
	remove_column :tenders, :contact_skype
  end
end
