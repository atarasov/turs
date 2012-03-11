class CountriesController < ApplicationController
  before_filter :get_settings
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit, :show])
  # GET /countries
  # GET /countries.xml
  def index
    sort = case params['sort']
             when "title"  then "title"
             when "rating"  then "rating DESC"
             when "review" then "review DESC"
             else "title"
          # when "name_reverse"  then "name DESC"
           #when "qty_reverse"   then "quantity DESC"
           #when "price_reverse" then "price DESC"
           end
    @countries = Country.paginate(:page => params[:page]).order(sort)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])
     @country.review += 1
      @country.save!
      @next_country = @country.next
      @prev_country = @country.previous
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.xml
  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.xml
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to(countries_url) }
      format.xml  { head :ok }
    end
  end

  def visa
	  @country = Country.find(params[:id])
    @visa = @country.visa

  @country.review += 1
   @country.save!
   @next_country = @country.next
   @prev_country = @country.previous
  end

  def phrasebook
	  @country = Country.find(params[:id])
    @phrasebook = @country.phrasebook
	  @country.review += 1
	   @country.save!
	   @next_country = @country.next
	   @prev_country = @country.previous
  end

  def embassy
	  @country = Country.find(params[:id])
    @embassy = Country.find(params[:id]).embassy
	@country.review += 1
  @country.save!
  @next_country = @country.next
  @prev_country = @country.previous
  end

  def memo
	  @country = Country.find(params[:id])
    @memo = @country.memo
	  @country.review += 1
	   @country.save!
	   @next_country = @country.next
	   @prev_country = @country.previous
  end

  def phones
    @countries = Country.all
  end
end
