class CategoriesController < ApplicationController

  def index
    @journals = Journal.paginate :page => params[:page], :order => 'created_at DESC'

  end

  def show
    @category = Category.find(params[:id])
    @journals = Journal.paginate :page => params[:page], :conditions =>{:category_id => params[:id]},  :order => 'created_at DESC'
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

end
