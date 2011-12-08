class CompanionController < ApplicationController
before_filter :login_required

  def index

	if params[:companion_advertisement].present? && params[:companion_advertisement].any?
	  @advertisements = CompanionAdvertisement.where(params[:companion_advertisement].delete_if{|key, value| !(value.present?)})
	else
	  @advertisements = CompanionAdvertisement.all
	end
  end

  def create
	params[:companion_advertisement][:user_id] = current_user.id
	params[:companion_advertisement][:from_city] = current_user.city_id
	@adv = CompanionAdvertisement.new(params[:companion_advertisement])
	if @adv.valid?
	  @adv.save
	  redirect_to :controller => :companion, :action => :index
	else
	  render :action => :new
	end
 end

  def new
	@adv = CompanionAdvertisement.new
  end

  def edit
	if params[:id].present?
	  @adv = CompanionAdvertisement.where(params[:id]).first
	  if @adv.present? && @adv.user_id == current_user.id
		render :action => :new
	  else
		redirect_to :controller => :companion, :action => :index
	  end
	else
	  redirect_to :controller => :companion, :action => :index
	end
  end

  def update

	if params[:id].present?

		@adv = CompanionAdvertisement.where(params[:id]).first
		if @adv.present? && @adv.user_id == current_user.id && params[:companion_advertisement].present?
			params[:companion_advertisement].delete :user_id
			params[:companion_advertisement].delete :from_city

		  	@adv.attributes = params[:companion_advertisement]
			if @adv.valid?
				@adv.save
				redirect_to :controller => :companion, :action => :index
			else
				render :action => :new
			end
		else
		  redirect_to :controller => :companion, :action => :index
		end
	else
	  redirect_to :controller => :companion, :action => :index
	end
  end

  def destroy
	if params[:id].present?
	  adv = CompanionAdvertisement.where(:id => params[:id]).first
	  if adv.present?
		adv.destroy
	  end
	end
  end

  def show
	if params[:id].present?
	  @adv = CompanionAdvertisement.where(params[:id]).first
	end
	if @adv.nil?
		redirect_to :controller => :companion, :action => :index
	end

  end

end
