module Admin::MainHelper


  def state_link(label, url, *args, &block)
    options = args.extract_options!
    options.reverse_merge!(
      :inactive_cls => nil,
      :active_cls => "chosen",
      :chosen_cls => "chosen",
      :sub => "",
      :link_options => {}
    )
    state = yield
    state = :active if state === true
    state = :inactive if state === false

    content = case state
    when :inactive, :chosen
      link_to label, url, options[:link_options] || {}
    when :active
      content_tag :span, options[:span_options] do
        label
      end
    end

    content += options[:sub].to_s

    content_tag :li, content, :class => options[:"#{state.to_s}_cls"]
  end
  
  def nav_link(label, active, chosen = nil, *args)
    options = args.extract_options!
    state = action_state(active, chosen)
    to_extract = active.is_a?(String) ? active : active.first
    controller, action = extract_controller_and_action(to_extract)
    action = :index if action == '*'

    url = options[:url] || url_for(options.merge(:controller => controller, :action => action))

    state_link(label, url, options) { state }
  end
end
