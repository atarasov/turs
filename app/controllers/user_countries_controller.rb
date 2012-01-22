class UserCountriesController < ApplicationController
  # GET /user_countries
  # GET /user_countries.xml
  def index
    @user_countries = UserCountry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_countries }
    end
  end

  # GET /user_countries/1
  # GET /user_countries/1.xml
  def show
    @user_country = UserCountry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_country }
    end
  end

  # GET /user_countries/new
  # GET /user_countries/new.xml
  def new
    @user_country = UserCountry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_country }
    end
  end

  # GET /user_countries/1/edit
  def edit
    @user_country = UserCountry.find(params[:id])
  end

  # POST /user_countries
  # POST /user_countries.xml
  def create
    @user_country = UserCountry.new(params[:user_country])
    @user_country.user_id = current_user.id
    respond_to do |format|
      if @user_country.save
        format.html { redirect_to(@user_country, :notice => 'User country was successfully created.') }
        format.xml  { render :xml => @user_country, :status => :created, :location => @user_country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_countries/1
  # PUT /user_countries/1.xml
  def update
    @user_country = UserCountry.find(params[:id])

    respond_to do |format|
      if @user_country.update_attributes(params[:user_country])
        format.html { redirect_to(@user_country, :notice => 'User country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_countries/1
  # DELETE /user_countries/1.xml
  def destroy
    @user_country = UserCountry.find(params[:id])
    @user_country.destroy

    respond_to do |format|
      format.html { redirect_to(user_countries_url) }
      format.xml  { head :ok }
    end
  end
end
