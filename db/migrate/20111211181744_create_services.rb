class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :user_id
      t.date :expire_date
      t.integer :amount
      t.boolean :is_test
      t.integer :status
      t.string :service_type

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
