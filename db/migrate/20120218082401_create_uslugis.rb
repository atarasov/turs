class CreateUslugis < ActiveRecord::Migration
  def self.up
    create_table :uslugis do |t|
      t.integer :val
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :uslugis
  end
end
