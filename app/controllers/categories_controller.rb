class CategoriesController < ApplicationController

  def index

    if params[:country]
      @journals = Journal.where(:country_id => params[:country]).paginate(:page => params[:page]).order("created_at DESC")
      @country  = Country.find(params[:country])
    elsif params[:user_id]
      @journals = Journal.where(:user_id => params[:user_id]).paginate(:page => params[:page]).order("created_at DESC")
      @author   = User.find(params[:user_id])
    else
      @journals = Journal.paginate :page => params[:page], :order => 'created_at DESC'
    end

  end

  def show
    @category = Category.find(params[:id])
    @journals = Journal.paginate :page => params[:page], :conditions =>{:category_id => params[:id]},  :order => 'created_at DESC'

    respond_to do |format|
      format.html { render :index }
      format.xml  { render :xml => @category }
    end
  end

end
