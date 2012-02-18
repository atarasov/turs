class UslugisController < ApplicationController
  # GET /uslugis
  # GET /uslugis.xml
  def index
    @uslugis = Uslugi.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uslugis }
    end
  end

  # GET /uslugis/1
  # GET /uslugis/1.xml
  def show
    @uslugi = Uslugi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @uslugi }
    end
  end

  # GET /uslugis/new
  # GET /uslugis/new.xml
  def new
    @uslugi = Uslugi.new
    @uslugis = Uslugi.where(:user_id => current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @uslugi }
    end
  end

  # GET /uslugis/1/edit
  def edit
    @uslugi = Uslugi.find(params[:id])
  end

  # POST /uslugis
  # POST /uslugis.xml
  def create
    @uslugi = Uslugi.new(params[:uslugi])
    @uslugi.user_id = current_user.id
    respond_to do |format|
      if @uslugi.save
        format.html redirect_to(:action => :new )
        format.xml  { render :xml => @uslugi, :status => :created, :location => @uslugi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @uslugi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uslugis/1
  # PUT /uslugis/1.xml
  def update
    @uslugi = Uslugi.find(params[:id])

    respond_to do |format|
      if @uslugi.update_attributes(params[:uslugi])
        format.html { redirect_to(@uslugi, :notice => 'Uslugi was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @uslugi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uslugis/1
  # DELETE /uslugis/1.xml
  def destroy
    @uslugi = Uslugi.find(params[:id])
    @uslugi.destroy

    respond_to do |format|
      format.html { redirect_to(uslugis_url) }
      format.xml  { head :ok }
    end
  end
end
