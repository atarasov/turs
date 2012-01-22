class ForPhotoReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :country_id, :integer
    add_column :reports, :journal_id, :integer
  end

  def self.down
    remove_column :reports, :country_id, :integer
    remove_column :reports, :journal_id, :integer
  end
end
