class CreateChatMessages < ActiveRecord::Migration
  def self.up
    create_table :chat_messages do |t|
		t.integer :from_user_id
		t.string :from_guest_name
   		t.integer :to_user_id
   		t.string :to_guest_name

		t.string :message, :nil => false
		t.timestamps
    end
  end

  def self.down
    drop_table :chat_messages
  end
end
