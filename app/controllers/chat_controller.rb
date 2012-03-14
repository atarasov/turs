class ChatController < ApplicationController
	before_filter :check_chat_auth, :except => [:login_chat, :logoff_chat]

  def say
	@messages = ChatMessage.say @user, params[:message]
	@clear_input = true
	render :action => :index
  end

  def index
	@messages = ChatMessage.get_messages
	@clear_input = false
  end

  def login_chat

	  if current_user.present?
		current_user.login_chat
	  else
		if params[:chat_guest_login].present?
			exist_users = User.where(:name => params[:chat_guest_login])
			if exist_users.any?
			  redirect_to :action => :logoff_chat, :message => "Недопустимое имя"
			else
			  session[:chat_guest_login] = params[:chat_guest_login].strip
			  index
			end
		else
		  redirect_to :action => :logoff_chat
		end
	  end


  end

  def logoff_chat
	session.delete :chat_guest_login
	if current_user.present?
	  current_user.logoff_chat
	end
	respond_to do |format|
	  format.html{render :action => :index}
	  format.js {render :action => :login_chat, :format => :js}
	end

  end

	private

  def check_chat_auth
	if current_user.present?
	  @user = current_user
	elsif session[:chat_guest_login].present?
	  @user = session[:chat_guest_login]
	else
	  redirect_to :action => :logoff_chat, :message => "Необходима авторизация"
	end
  end

end
