class UserHotelsController < ApplicationController
  # GET /user_hotels
  # GET /user_hotels.xml
  def index
    @user_hotels = UserHotel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_hotels }
    end
  end

  # GET /user_hotels/1
  # GET /user_hotels/1.xml
  def show
    @user_hotel = UserHotel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_hotel }
    end
  end

  # GET /user_hotels/new
  # GET /user_hotels/new.xml
  def new
    @user_hotel = UserHotel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_hotel }
    end
  end

  # GET /user_hotels/1/edit
  def edit
    @user_hotel = UserHotel.find(params[:id])

  end

  # POST /user_hotels
  # POST /user_hotels.xml
  def create
    @user_hotel = UserHotel.new(params[:user_hotel])
    @user_hotel.user_id = current_user.id
    respond_to do |format|
      if @user_hotel.save
        format.html { redirect_to(@user_hotel, :notice => 'User hotel was successfully created.') }
        format.xml  { render :xml => @user_hotel, :status => :created, :location => @user_hotel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_hotel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_hotels/1
  # PUT /user_hotels/1.xml
  def update
    @user_hotel = UserHotel.find(params[:id])

    respond_to do |format|
      if @user_hotel.update_attributes(params[:user_hotel])
        format.html { redirect_to(@user_hotel, :notice => 'User hotel was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_hotel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_hotels/1
  # DELETE /user_hotels/1.xml
  def destroy
    @user_hotel = UserHotel.find(params[:id])
    @user_hotel.destroy

    respond_to do |format|
      format.html { redirect_to(user_hotels_url) }
      format.xml  { head :ok }
    end
  end
end
