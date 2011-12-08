class TenderController < ApplicationController
   before_filter :login_required, :except => [:index, :new, :create]

  def index
	if params[:conditions].present?
	  @tenders = Tender.where(params[:conditions])
	else
	  @tenders = Tender.all
	end
  end

  def new
    @tender = Tender.new
  end

  def create
    @tender = Tender.new(params[:tender])
    if @tender.save
      redirect_to :action => :index
    else
      render :new
    end

  end

end
