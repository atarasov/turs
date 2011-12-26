class AddProfessionToMentions < ActiveRecord::Migration
  def self.up
	add_column :mentions, :profession, :string, :nil => false, :default => ""
  end

  def self.down
	remove_column :mentions, :profession
  end
end
