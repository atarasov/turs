class JournalsController < ApplicationController
  before_filter :find_comments, :only => [:show]
  uses_tiny_mce(:options => AppConfig.for_comment_mce_options, :only => [:new, :edit, :show])
  # GET /journals

  def find_comments
    commentable = params[:id].present? ? Journal.find(params[:id]) : Journal.find(params[:journal_id])
    @comments = commentable.comments.recent.all
  end
  # GET /journals.xml
  def index
    if params[:country]
      @journals = Journal.where(:country_id => params[:country]).order("created_at DESC")
    elsif params[:user_id]
      @journals = Journal.where(:user_id => params[:user_id]).order("created_at DESC")
    else
      @journals = Journal.order("created_at DESC").all
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @journals }
    end
  end

  # GET /journals/1
  # GET /journals/1.xml
  def show
    @journal = Journal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @journal }
    end
  end

  # GET /journals/new
  # GET /journals/new.xml
  def new
    @journal = Journal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @journal }
    end
  end

  # GET /journals/1/edit
  def edit
    @journal = Journal.find(params[:id])
  end

  # POST /journals
  # POST /journals.xml
  def create
    @journal = Journal.new(params[:journal])
    @journal.user = current_user
    @journal.category = Category.find(params[:category_id])
    respond_to do |format|
      if @journal.save
        format.html { redirect_to(category_url(params[:category_id]), :notice => 'Journal was successfully created.') }
        format.xml  { render :xml => @journal, :status => :created, :location => @journal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @journal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /journals/1
  # PUT /journals/1.xml
  def update
    @journal = Journal.find(params[:id])

    respond_to do |format|
      if @journal.update_attributes(params[:journal])
        format.html { redirect_to(@journal, :notice => 'Journal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @journal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_comment
    commentable = Journal.find(params[:journal_id])
    commentable.comments.create(:comment => params[:comment][:text])
    redirect_to :action => :show, :id => params[:journal_id]
  end

  # DELETE /journals/1
  # DELETE /journals/1.xml
  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy

    respond_to do |format|
      format.html { redirect_to(journals_url) }
      format.xml  { head :ok }
    end
  end
end
