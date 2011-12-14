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

  def command_index
	@profile = User.where(:id => params[:id]).first

  end

  def add_to_command
	current_user.headed_teams.create(:member_id => params[:id])

	redirect_to :action => :command_index, :id => current_user.id
  end

  def accept_command_call
	command = Command.find(params[:command_id])
	if command.member_id == current_user.id
	  command.is_confirmed = true
	  command.save
	end

	redirect_to :action => :command_index, :id => command.leader_id
  end

  def decline_command_call
	command = Command.find(params[:command_id])
	if command.member_id == current_user.id
	  command.destroy
	end

	redirect_to company_profile_url(current_user.id)
  end

  def recommendation_index
	@profile = User.find(params[:id])
  end

  def add_recommendation
	current_user.given_recommendations.create(:recommended_user_id => params[:id])
	redirect_to :action => :recommendation_index
  end

  def favorite_index
	@profile = User.find(params[:id])
  end

  def add_favorite
	current_user.favorite_users.create(:favorite_id => params[:id])
	redirect_to :action => :favorite_index, :id => current_user.id
  end

  def remove_favorite
	current_user.favorite_users.where(:id => params[:favorite_id].to_i).delete_all()
	redirect_to :action => :favorite_index, :id => current_user.id
  end
end
