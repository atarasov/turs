class ApplicationController < ActionController::Base
  include UrlHelper
  helper LaterDude::CalendarHelper
  protect_from_forgery

  helper :all, :action_link
  before_filter :get_settings, :get_journal_categories, :set_locale, :get_new_turs
  #skip_before_filter :verify_authenticity_token
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  include AuthenticatedSystem

  helper_method :current_page
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e125a4be589f9d81263920581f6e4182'

  # raised in #current_site
  rescue_from Site::UndefinedError do |e|
    redirect_to new_site_path
  end

  def current_page
    @page ||= [1, params[:page].to_i].max
  end

  def get_settings
    @turs_informer = Tur.limit(3)
    @settings = Settings.instance
  end

  def get_journal_categories
    @journal_categories = Category.find(:all)
  end

  def get_new_turs
    @new_turs = Tur.limit(5)
  end


  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]

    # set locale based on session or default
    I18n.locale = session[:locale] || I18n.default_locale
  end

end
