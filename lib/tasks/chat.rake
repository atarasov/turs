# encoding: UTF-8
namespace :sms_notifier do
  desc "Удалить неактивных пользователей и старые сообщения"
  task :clear => :environment do
	ChatUser.where("last_chat_update < ?", Time.now - 3.minutes).delete_all
	ChatMessage.where("created_at < ?", Time.now - 1.hour).delete_all
  end
end