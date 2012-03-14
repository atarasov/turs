class ChatMessage < ActiveRecord::Base

  default_scope order("created_at desc")

  belongs_to :from_user, :class_name => "User"
  belongs_to :to_user, :class_name => "User"

  def self.get_messages
	limit(100)
  end

  def self.say user, message
  	add_message user, message
  	get_messages
  end

  def get_from_user
	if self.from_user_id.present?
	  self.from_user.login
	else
	  self.from_guest_name
	end
  end
  def get_to_user
	if self.to_user_id.present?
	  self.to_user.login
	else
	  self.to_guest_name
	end
  end

  private

    def self.add_message user, message
	if message.present?
		arr_message_params = pars_message message, user
		#todo добавить в рэйк-таскс очистку чата
		ChatMessage.create(arr_message_params)
	end
  end

  def self.pars_message(message, sender)
	result = Hash.new
	if sender.class.name.eql?("User")
	  result[:from_user_id] = sender.id
	else
	  result[:from_guest_name] = sender
	end

	pars_arr = (/(<.*?>|)(.+|)/.match message)

	to_login = (/<(.*?|)>/.match pars_arr[1])
	to_login = to_login[1] if to_login.present?

	if to_login.present?
		to_user = User.where(:name => to_login)
	else
		to_user = nil
	end

	if to_user.present? && to_user.is_in_chat?
	  result[:to_user_id] = to_user.id
	else
	  result[:to_guest_name] = to_login
	end


	result[:message] = pars_arr[2]

	result
  end
end
