class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.xml
  def index
    @reports = Report.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.xml
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.xml
  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /reports
  # POST /reports.xml
  def create
    @report = Report.new(params[:report])
    @report.user_id = current_user.id
    #@report = Report.new(params[:upload])
    #if @report.save
    #  render :json => { :pic_path => @report.picture.url.to_s , :name => @report.picture.instance.attributes["picture_file_name"] }, :content_type => 'text/html'
    #else
    #  render :json => { :result => 'error'}, :content_type => 'text/html'
    #end

    respond_to do |format|
      if @report.save
        format.html { redirect_to(edit_report_url(@report), :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.xml
  def update
    @report = Report.find(params[:id])

    #respond_to do |format|
    #  if @report.report_photos.create(:image => params[:report][:image])
    #    format.html { redirect_to(@report, :notice => 'Report was successfully updated.') }
    #    format.xml  { head :ok }
    #  else
    #    format.html { render :action => "edit" }
    #    format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
    #  end
    #end
    @rp = @report.report_photos.new()

    @rp.image = params[:report][:image][0]
    if @rp.save!
      render :json => { :pic_path =>  @rp.image.url.to_s , :name =>  @rp.image.instance.attributes["picture_file_name"] }, :content_type => 'text/html'
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end

  end

  # DELETE /reports/1
  # DELETE /reports/1.xml
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end
end
