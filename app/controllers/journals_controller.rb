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
    redirect_to :controller => "categories", :user_id => params[:user_id]

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @journals }
    #end
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

#    @journal.category = Category.find(params[:category_id])
    respond_to do |format|
      if @journal.save
        format.html { redirect_to(category_url(params[:journal][:category_id]), :notice => 'Journal was successfully created.') }
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
        format.html { redirect_to(category_url(params[:journal][:category_id]), :notice => 'Journal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @journal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_comment
    commentable = Journal.find(params[:journal_id])
    commentable.comments.create(:comment => params[:comment][:text],
                                :user_id => (current_user.nil? ? nil: current_user.id),
                                :title => params[:comment][:title] || 'Alter Ego' )
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

  def add_photo
    @journal_photos = params[:journal_photos] || []

    for photo in @journal_photos do
			#raise photos.inspect
			@photo = JournalPhoto.new(:image => photo)
      if params[:journal_id]
			  @photo.journal_id = params[:journal_id]
      end
      unless @photo.save
        break# unless @photos.save
      end
    end
    #redirect_to admin_facility_path(params[:facility])
    respond_to do |format|
      format.html {
        render :partial => "add_photo"
      }
      format.json {
        render :partial => "add_photo"
      }
    end
  end

  def drop_photo

    facility_photo = FacilityPhoto.find(params[:id].to_i)
    #if ((!(current_admin.is_operator)) || (current_admin.area_id == facility_photo.facility.area_id))
      facility_photo.destroy
    #end
    respond_to do |format|
      format.html {
        #TODO: что-то с экшэном придумать (у партнёров тожеы)
        redirect_to :controller => "admin/journal", :action => "new"
      }
      format.js {
        render :js => "jQuery('#photos#{params[:id]}').remove()"
      }
    end
  end

end
