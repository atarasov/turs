class Company::ProfilesController < Company::BaseController
  def index
  end

  def edit
    @countries = Country.all
    @user = User.find(params[:id])
  end

  def show
    @profile = User.find(params[:id])
    @stends = @profile.stends
      @profile.review += 1
      @profile.save!
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end

  end

  def update
    @user = User.find(params[:id])
    countries = params[:ids] || []
    unless countries.empty?
      countries.each do |country|
        Direction.create(:user_id => @user.id, :country_id => country)
      end
    end
    #@user.avatar = params[:user][:avatar]
    if params[:us][:type]
      params[:user][:is_user] = false
      if params[:us][:type].eql?(1) || params[:us][:type].eql?("1")
        params[:user][:is_hotel] = true

        params[:user][:is_tour_operator]  = false
        params[:user][:is_recreation_center]  = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel]  = false
        params[:user][:is_guide]  = false
        params[:user][:is_taxi]  = false
        params[:user][:is_mini_hotel]  = false
        params[:user][:is_tour_agency ] = false
      elsif params[:us][:type].eql?(2) || params[:us][:type].eql?("2")
        params[:user][:is_tour_operator]  = true

        params[:user][:is_recreation_center ] = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel]  = false
        params[:user][:is_guide]  = false
        params[:user][:is_taxi]  = false
        params[:user][:is_mini_hotel]  = false
        params[:user][:is_tour_agency]  = false
        params[:user][:is_hotel] = false
      elsif params[:us][:type].eql?(3) || params[:us][:type].eql?("3")
        params[:user][:is_recreation_center]  = true

        params[:user][:is_tour_agency]  = false
        params[:user][:is_tour_operator]  = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel]  = false
        params[:user][:is_guide]  = false
        params[:user][:is_taxi]  = false
        params[:user][:is_mini_hotel]  = false
        params[:user][:is_hotel] = false
      elsif params[:us][:type].eql?(4) || params[:us][:type].eql?("4")
        params[:user][:is_sanatorium]  = true

        params[:user][:is_tour_operator] = false
        params[:user][:is_recreation_center] = false
        params[:user][:is_hostel] = false
        params[:user][:is_guide] = false
        params[:user][:is_taxi] = false
        params[:user][:is_mini_hotel] = false
        params[:user][:is_tour_agency] = false
        params[:user][:is_hotel] = false
      elsif params[:us][:type].eql?(5) || params[:us][:type].eql?("5")
        params[:user][:is_hostel]  = true

        params[:user][:is_tour_operator] = false
        params[:user][:is_recreation_center] = false
        params[:user][:is_sanatorium] = false
        params[:user][:is_guide] = false
        params[:user][:is_taxi] = false
        params[:user][:is_mini_hotel] = false
        params[:user][:is_tour_agency] = false
        params[:user][:is_hotel] = false
      elsif params[:us][:type].eql?(6) || params[:us][:type].eql?("6")
        params[:user][:is_guide] = true

        params[:user][:is_tour_agency] = false
        params[:user][:is_tour_operator]  = false
        params[:user][:is_recreation_center] = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel] = false
        params[:user][:is_taxi]  = false
        params[:user][:is_mini_hotel]  = false
        params[:user][:is_hotel] = false
        #raise params[:user].inspect
      elsif params[:us][:type].eql?(7) || params[:us][:type].eql?("7")
        params[:user][:is_taxi]  = true

        params[:user][:is_tour_operator]  = false
        params[:user][:is_recreation_center]  = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel]  = false
        params[:user][:is_guide]  = false
        params[:user][:is_mini_hotel]  = false
        params[:user][:is_tour_agency]  = false
        params[:user][:is_hotel] = false
      elsif params[:us][:type].eql?(8) || params[:us][:type].eql?("8")
        params[:user][:is_mini_hotel]  = true

        params[:user][:is_tour_agency]  = false
        params[:user][:is_tour_operator]  = false
        params[:user][:is_recreation_center]  = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel]  = false
        params[:user][:is_guide]  = false
        params[:user][:is_taxi]  = false
        params[:user][:is_hotel] = false
      elsif params[:us][:type].eql?(9) || params[:us][:type].eql?("9")
        params[:user][:is_tour_agency]  = true

        params[:user][:is_tour_operator]  = false
        params[:user][:is_recreation_center]  = false
        params[:user][:is_sanatorium]  = false
        params[:user][:is_hostel]  = false
        params[:user][:is_guide]  = false
        params[:user][:is_taxi]  = false
        params[:user][:is_mini_hotel]  = false
        params[:user][:is_hotel] = false
      else


      end
    end
    #raise params[:user].inspect
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to company_profile_url(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

end
