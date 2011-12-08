class AddCountryToJournal < ActiveRecord::Migration
  def self.up
    add_column :journals, :country_id, :integer
  end

  def self.down
    remove_column :journals, :country_id
  end
end
