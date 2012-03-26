module ChatHelper
  def from_user(message)
	if current_user.present? && message.from_user_id.eql?(current_user.id)
	  " from-me"
	elsif current_user.nil? && message.from_guest_name.eql?(session[:chat_guest_login])
	  " from-me"
	else
	  ""
	end
  end

  def to_user(message)
	if current_user.present? && message.to_user_id.eql?(current_user.id)
	  " to-me"
	elsif current_user.nil? && message.to_guest_name.eql?(session[:chat_guest_login])
	  " to-me"
	else
	  ""
	end
  end

  def online_user(chat_user)
	if current_user.present?
		if FavoriteUser.where(:preferred_user_id => chat_user.user_id, :user_id => current_user.id).any?
			"<span class=\"favourite-user\">" +
				link_to_function(chat_user.user.login, "say('#{chat_user.user.login}')") +
				" <span class=\"remove-from-favourite\">".html_safe +
				link_to("Удалить из избранного", url_for(:controller => "chat", :action => "remove_preferred_user", :id => chat_user.user_id),
						:method => :post, :remote => true, :confirm => "Вы уверены?") +
				"</span></span>"
		else
		  link_to_function(chat_user.user.login, "say('#{chat_user.user.login}')") +
			  "<span class=\"add-to-favourite\">".html_safe +
			  link_to("Добавить в избранное", url_for(:controller => "chat", :action => "add_preferred_user", :id => chat_user.user_id),
			  :method => :post, :remote => true, :confirm => "Вы уверены?") +
			  "</span>".html_safe
		end
	else
	  link_to_function(chat_user.user.login, "say('#{chat_user.user.login}')")
	end
  end
end
