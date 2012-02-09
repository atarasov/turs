class Company::PhotosController < Company::BaseController
  #skip_before_filter :profile_find, :only => [:ordering, :change_order]
  def index
    @photos = Photo.where(:user_id => params[:id]).order("photos.order")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
   # @photos = Photo.where(:user_id => params[:id]).order("photos.order")
    @photo = Photo.find(params[:id])
  end

  #def ordering
  #  @photos = Photo.where(:user_id => params[:id]).order("photos.order")
  #end

  def change_order
    @order_list = params[:order_list]
    Photo.sort(@order_list.split(','))
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = params[:id]
    respond_to do |format|
      if @photo.save
        format.html { redirect_to(@photo, :notice => 'Photo was successfully created.') }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photos = params[:photos]
    #@photo = Photo.find(params[:id])
    #@photo.user_id = params[:id]
    @photos.each do |key, value|
      @photo = Photo.find(key)
      #raise @photo.inspect
      @photo.title = value[:title]
      @photo.description = value[:description]
      unless @photo.save!
        render :action => "edit"
      end

      #raise key.inspect
      #Photo.update(key, {:title => value[:title], :description => value[:description]})
    end
    respond_to do |format|
      #if @photo.update_attributes(params[:photo])
        format.html { redirect_to(:action => 'index')}
        #format.xml  { head :ok }
      #else
      #  format.html { render :action => "edit" }
      #  format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      #end
    end
  end

  def add_photo
    @photos = params[:photos] || []

    for photo in @photos do
			#raise photos.inspect
			@photo = Photo.new(:image => photo)
      if params[:id]
			  @photo.user_id = params[:id]
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
        redirect_to :controller => "company/photos", :action => "new"
      }
      format.js {
        render :js => "jQuery('#photos#{params[:id]}').remove()"
      }
    end
  end


  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
end
