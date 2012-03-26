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
		index
	  else
		if params[:chat_guest_login].present?
			exist_users = User.where(:name => params[:chat_guest_login]) + ChatUser.where(:guest_name => params[:chat_guest_login])
			if exist_users.any?
			  redirect_to :action => :logoff_chat, :message => "Недопустимое имя"
			else
			  session[:chat_guest_login] = params[:chat_guest_login].strip
			  ChatUser.create(:guest_name => params[:chat_guest_login], :last_chat_update => Time.now)
			  index
			end
		else
		  render :action => :index
		end
	  end


  end

  def logoff_chat
	if current_user.present?
	  current_user.logoff_chat
	else
	  ChatUser.delete_all(:guest_name => session[:chat_guest_login])
	end
	session.delete :chat_guest_login
	respond_to do |format|
	  format.html{render :action => :index}
	  format.js {render :action => :login_chat, :format => :js}
	end

  end
  def add_preferred_user
	if current_user.present? && params[:user_id].present?
	  if Users.where(:id => params[:user_id]).any? && FavoriteUser.where(:preferred_user_id =>params[:user_id].to_i, :user_id => current_user.id).empty?
		current_user.create_favorite_user(:prefered_user_id => params[:user_id])
	  end
	end
	redirect_to :action => :index
  end

  def remove_preferred_user
	if current_user.present? && params[:user_id].present?
	  current_user.preferred_users.where(:id => params[:user_id], :user_id => current_user.id).delete_all
	end
	redirect_to :action => :index
  end
		private

  def check_chat_auth
	if current_user.present? && current_user.chat_user
	  @user = current_user.chat_user
	  @user.update_attribute(:last_chat_update, Time.now)
	elsif session[:chat_guest_login].present?
	  @user = ChatUser.where(:guest_name => session[:chat_guest_login]).first
	  @user.update_attribute(:last_chat_update, Time.now)
	else
	  redirect_to :action => :logoff_chat, :message => "Необходима авторизация"
	end
  end

end
