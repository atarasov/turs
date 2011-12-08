module ActionLinkHelper#:doc:
  # Returns true if current controller and action names equals to any of passed.
  # Asterik as action name matches all controller's action.
  #
  # Examples:
  #   <%= "we are in PostsController::index" if current_action_any_of?("posts/index") %>
  #
  #   <%= "we are not in PostsController::index" unless current_action_any_of?("posts/index") %>
  #
  #   <% if current_action_any_of?("posts/index", "messages/index") %>
  #     we are in PostsController or in MessagesController
  #   <% end %>
  #
  def current_action_any_of?(*actions)
    actions.any? do |sub_ca|
      sub_controller, sub_action = extract_controller_and_action(sub_ca)
      @controller.controller_path == sub_controller && (@controller.action_name == sub_action || sub_action == '*')
    end
  end

  # Returns link state related to current controller and action: :inactive, :active or :chosen.
  # A list of active actions is the first argument, chosen actions are the second argument.
  #
  # Examples:
  #   # :active for PostsController::index, :chosen for PostsController::* (except :index), 
  #   # :inactive otherwise.
  #   action_state("posts/index", "posts/*")
  #   
  #   # :active for PostsController::new and PostsController::create, :inactive otherwise.
  #   action_state(["posts/new", "posts/create"])
  #
  #   # :active for PostsController::index, :chosen for MessagesController::* and
  #   # PostsController::* (except :index), :inactive otherwise.
  #   action_state("posts/index", ["posts/*", "messages/*"])
  #
  def action_state(active_string_or_array, chosen_string_or_array)
    active = active_string_or_array.is_a?(String) ? [active_string_or_array] : active_string_or_array
    chosen = chosen_string_or_array.is_a?(String) ? [chosen_string_or_array] : chosen_string_or_array

    if current_action_any_of?(*active_string_or_array)
      :active
    else
      if !chosen_string_or_array.nil? && current_action_any_of?(*chosen_string_or_array) 
        :chosen
      else
        :inactive    
      end    
    end
  end
 
  # Extracts controller and action names from a string.
  #
  # Examples:
  #
  #   extract_controller_and_action("posts/index")       # ["posts", "index"]
  #   extract_controller_and_action("admin/posts/index") # ["admin/posts", "index"]
  #   extract_controller_and_action("admin/posts/index") # raises ArgumentError
  #
  def extract_controller_and_action(ca)
    raise ArgumentError, "Pass the string" if ca.nil?
    slash_pos = ca.rindex('/')
    raise ArgumentError, "Invalid action: #{ca}" if slash_pos.nil?
    controller = ca[0, slash_pos]
    action = ca[slash_pos+1..-1]
    raise ArgumentError, "Invalid action or controller" if action.nil? or controller.nil?

    [controller, action]
  end
end