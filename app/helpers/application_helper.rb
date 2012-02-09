require 'digest/md5'
module ApplicationHelper
  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << {:url => url, :title => title}
    link_to image_tag('feed-icon.png', :size => '14x14', :alt => "Subscribe to #{title}"), url
  end

  def flash_messages
    flash.map do |name, message|
      content_tag :p, message, :class => [:notice, name].uniq.join(' ')
    end.join.html_safe if flash.present?
  end

  def pagination(collection)
    if collection.total_entries > 1
      "<p class='pages'>" + I18n.t('txt.pages', :default => 'Pages') + ": <strong>" +
          will_paginate(collection, :inner_window => 10, :next_label => I18n.t('txt.page_next', :default => 'next'), :prev_label => I18n.t('txt.page_prev', :default => 'previous')) +
          "</strong></p>"
    end
  end

  def next_page(collection)
    unless collection.current_page == collection.total_entries or collection.total_entries == 0
      "<p style='float:right;'>" + link_to(I18n.t('txt.next_page', :default => 'next page'), {:page => collection.current_page.next}.merge(params.reject { |k, v| k=="page" })) + "</p>"
    end
  end

  def search_posts_title
    (params[:q].blank? ? I18n.t('txt.recent_posts', :default => 'Recent Posts') : I18n.t('txt.searching_for', :default => 'Searching for') + " '#{params[:q]}'").tap do |title|
      title << " " + I18n.t('txt.by_user', :default => 'by %{user}', :user => @user.display_name) if @user
      title << " " + I18n.t('txt.in_forum', :default => 'in %{forum}', :forum => @forum.name) if @forum
    end
  end

  def topic_title_link(topic, options)
    if topic.title =~ /^\[([^\]]{1,15})\]((\s+)\w+.*)/
      "<span class='flag'>#{$1}</span>" +
          link_to($2.strip, forum_topic_path(@forum, topic), options)
    else
      link_to(topic.title, forum_topic_path(@forum, topic), options)
    end
  end

  def topic_title_link2(topic, forum, options)
    if topic.title =~ /^\[([^\]]{1,15})\]((\s+)\w+.*)/
      "<span class='flag'>#{$1}</span>" +
          link_to($2.strip, forum_topic_path(forum, topic), options)
    else
      link_to(topic.title, forum_topic_path(forum, topic), options)
    end
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
    "<img src='/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner'> ".html_safe
  end

  def avatar_for(user, size=32)
    image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{Digest::MD5.hexdigest(user.email)}&rating=PG&size=#{size}", :size => "#{size}x#{size}", :class => 'photo'
  end

  def search_path(atom = false)
    options = params[:q].blank? ? {} : {:q => params[:q]}
    prefix =
        if @topic
          options.update :topic_id => @topic, :forum_id => @forum
          :forum_topic
        elsif @forum
          options.update :forum_id => @forum
          :forum
        elsif @user
          options.update :user_id => @user
          :user
        else
          :search
        end
    atom ? send("#{prefix}_posts_path", options.update(:format => :atom)) : send("#{prefix}_posts_path", options)
  end

  def for_moderators_of(record, &block)
    capture(&block) if moderator_of?(record)
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def truncate(text, *args)
    return '' unless text
    options = args.extract_options!

    unless args.empty?
      options[:length] = args[0] || 30
      options[:omission] = args[1] || "..."
    end
    options.reverse_merge!(:length => 30, :omission => "...")

    chars = if text.respond_to?(:mb_chars)
              text.mb_chars
            elsif RUBY_VERSION < '1.9'
              text.chars
            else
              text
            end

    omission = if options[:omission].respond_to?(:mb_chars)
                 options[:omission].mb_chars
               elsif RUBY_VERSION < '1.9'
                 options[:omission].chars
               else
                 options[:omission]
               end

    l = options[:length] - omission.length
    if chars.length > options[:length]
      result = (chars[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m]).to_s
      ((options[:avoid_orphans] && result =~ /\A(.*?)\n+\W*\w*\W*\Z/m) ? $1 : result) + options[:omission]
    else
      text
    end
  end

  def delete_batch_button
    submit_tag "Удалить", :class => "submit-form", :name => :destroy
  end

  def ids(obj, checked = nil)
    check_box_tag "ids[]", obj.id, checked
  end

  def role(user)
    if user.is_hotel?
      "Отели"
    elsif user.is_tour_operator
      "Туроператоры"
    elsif user.is_recreation_center
      "Базы отдыха"
    elsif user.is_sanatorium
      "Санатории"
    elsif user.is_hostel
      "Гостинницы"
    elsif user.is_guide
      "Гиды"
    elsif user.is_taxi
      "Такси"
    elsif user.is_mini_hotel
      "Мини отели"
    else
      "Туристы"
    end
  end

  def role_link(user)
    if user.is_hotel
      hotels_catalog_index_url(:subdomain => false)
    elsif user.is_tour_operator
      tour_operators_catalog_index_url(:subdomain => false)
    elsif user.is_recreation_center
      recreation_centers_catalog_index_url(:subdomain => false)
    elsif user.is_sanatorium
      sanatorium_catalog_index_url(:subdomain => false)
    elsif user.is_hostel
      hostel_catalog_index_url(:subdomain => false)
    elsif user.is_guide
      guide_catalog_index_url(:subdomain => false)
    elsif user.is_taxi
      taxi_catalog_index_url(:subdomain => false)
    elsif user.is_mini_hotel
      mini_hotels_catalog_index_url(:subdomain => false)
    else
      catalog_index_url(:subdomain => false)
    end
  end

  def country_val obj
    if obj && obj.country_id
      obj.country_id
    else
      nil
    end
  end

  def stend_val obj
    if obj && obj.id
      obj.id
    else
      nil
    end
  end

  def price_val obj
    if obj && obj.price
      obj.price
    else
      ""
    end

  end

  def days_val obj
    if obj && obj.days
      obj.days
    else
      ""
    end

  end

  def user_val obj
    if obj && obj.user
      obj.user.id
    else
      nil
    end

  end

  def type_profile(user)
    if user.is_hotel
      "Отель"
    elsif user.is_tour_operator
      "Тур оператор"
    elsif user.is_recreation_center
      "База отдыха"
    elsif user.is_sanatorium
      "Санаторий"
    elsif user.is_hostel
      "Гостинница"
    elsif user.is_guide
      "Гид"
    elsif user.is_taxi
      "Такси"
    elsif user.is_mini_hotel
      "Мини отель"
    elsif user.is_tour_agency
      "Турагенство"
    else
      "Турист"
    end

  end

  def type_profiles(user)
    if user.is_hotel
      link_to_unless_current "Отели", hotels_catalog_index_url(:subdomain => false)
    elsif user.is_tour_operator
      link_to_unless_current "Туроператоры", tour_operators_catalog_index_url(:subdomain => false)
    elsif user.is_recreation_center
      link_to_unless_current "Базы отдыха", recreation_centers_catalog_index_url(:subdomain => false)
    elsif user.is_sanatorium
      link_to_unless_current "Санатории", sanatorium_catalog_index_url(:subdomain => false)
    elsif user.is_hostel
      link_to_unless_current "Гостинницы", hostel_catalog_index_url(:subdomain => false)
    elsif user.is_guide
      link_to_unless_current "Гиды", guide_catalog_index_url(:subdomain => false)
    elsif user.is_taxi
      link_to_unless_current "Такси", taxi_catalog_index_url(:subdomain => false)
    elsif user.is_mini_hotel
      link_to_unless_current "Мини-отели", mini_hotels_catalog_index_url(:subdomain => false)
    elsif user.is_tour_agency
      link_to_unless_current "Турагенства", tour_agencies_catalog_index_url(:subdomain => false)
    else
      "Туристы"
    end

  end


end
