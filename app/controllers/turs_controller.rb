class TursController < ApplicationController

  #before_filter

  def index
    if params[:user_id]
      @turs = Tur.where(:user_id => params[:user_id])
    else
      @turs = Tur.all
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @turs }
    end
  end

  def rss
    @turs = Tur.all( :order => "created_at DESC", :limit => 20)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  # GET /turs/1
  # GET /turs/1.xml
  def show
    @tur = Tur.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tur }
    end
  end

  # GET /turs/new
  # GET /turs/new.xml
  def new
    @tur = Tur.new
    @countries = Country.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tur }
    end
  end

  # GET /turs/1/edit
  def edit
    @countries = Country.all
    @tur = Tur.find(params[:id])
  end

  # POST /turs
  # POST /turs.xml
  def create
    @tur = Tur.new(params[:tur])

    respond_to do |format|
      if @tur.save
        format.html { redirect_to(@tur, :notice => 'Tur was successfully created.') }
        format.xml  { render :xml => @tur, :status => :created, :location => @tur }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tur.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /turs/1
  # PUT /turs/1.xml
  def update
    @tur = Tur.find(params[:id])

    respond_to do |format|
      if @tur.update_attributes(params[:tur])
        format.html { redirect_to(@tur, :notice => 'Tur was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tur.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /turs/1
  # DELETE /turs/1.xml
  def destroy
    @tur = Tur.find(params[:id])
    @tur.destroy

    respond_to do |format|
      format.html { redirect_to(turs_url) }
      format.xml  { head :ok }
    end
  end
end
