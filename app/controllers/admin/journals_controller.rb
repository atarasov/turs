class Admin::JournalsController < Admin::BaseController
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])
  # GET /journals
  # GET /journals.xml
  def index
    @journals = Journal.all

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
    @countries = Country.all
    @categories = Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @journal }
    end
  end

  # GET /journals/1/edit
  def edit
    @countries = Country.all
    @categories = Category.all
    @journal = Journal.find(params[:id])
  end

  # POST /journals
  # POST /journals.xml
  def create
    @journal = Journal.new(params[:journal])
    params[:journal][:country_id] =  params[:journal][:country_id].to_i if params[:journal][:country_id]
    @journal.user = current_user
    if params[:category_id]
      @journal.category = Category.find(params[:category_id])
    elsif params[:journal][:category_id]
      @journal.category = Category.find(params[:journal][:category_id])
    end
    respond_to do |format|
      if @journal.save
        format.html { redirect_to(admin_journals_url(), :notice => 'Journal was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /journals/1
  # PUT /journals/1.xml
  def update
    @journal = Journal.find(params[:id])
    params[:journal][:country_id] =  params[:journal][:country_id].to_i if params[:journal][:country_id]
    if params[:category_id]
      @journal.category = Category.find(params[:category_id])
    elsif params[:journal][:category_id]
      params[:journal][:category_id] = @journal.category if !params[:journal][:category_id] || params[:journal][:category_id].eql?("")
      @journal.category = Category.find(params[:journal][:category_id])
    end

    respond_to do |format|
      if @journal.update_attributes(params[:journal])
        format.html { redirect_to(admin_journals_url(), :notice => 'Journal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @journal.errors, :status => :unprocessable_entity }
      end
    end
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
