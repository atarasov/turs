class ChatUser < ActiveRecord::Base
  belongs_to :user

  scope :online, where("last_chat_update > ?", (Time.now - 1.minutes))
end
