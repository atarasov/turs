class AddLinkToSite < ActiveRecord::Migration
  def self.up
    add_column :users, :link_to_site, :string, :default => " "
  end

  def self.down
    remove_column :users, :link_to_site
  end
end
