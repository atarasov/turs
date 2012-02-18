class ChangeRatingType < ActiveRecord::Migration
  def self.up
	  change_column :users, :raiting, :float
  end

  def self.down
	  change_column :users, :raiting, :integer
  end
end
