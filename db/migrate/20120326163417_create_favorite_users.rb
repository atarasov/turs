class CreateFavoriteUsers < ActiveRecord::Migration
  def self.up
    create_table :favorite_users do |t|
	  t.integer :user_id, :nil => false
	  t.integer :preferred_user_id, :nil => false
      t.timestamps
    end
  end

  def self.down
    drop_table :favorite_users
  end
end
