class MentionController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  #or other login req?
  before_filter :login_required, :only => [:destroy]

  def index
	@mentions = Mention.paginate(:page => current_page, :order => 'created_at desc')

  end

  def new
	@mention = Mention.new()

  end

  def create
	if simple_captcha_valid?
		@mention = Mention.new(params[:mention])
	  	if @mention.valid?
			@mention.save
			redirect_to :action => :index
		else
			render :action => :new
		end
	else
	  flash[:notice] = "Неверный защитный код"
	  redirect_to :action => :new
	end

  end

  def destroy
	if params[:id].present?
	  Mention.delete(params[:id])
	elsif params[:ids].present?
	  Mention.delete(params[:ids])
	end
	redirect_to :action => :index
  end
end
