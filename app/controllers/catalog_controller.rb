class CatalogController < ApplicationController
  before_filter :find_vip
  def index
    @users = User.where("raiting >= 15")
	if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
  end

  def find_vip
    @vips = VipPlacement.where("status = ? " ,Service::STATUS[:active]).group(:user_id)
  end

  def hotels
     @users = User.where(:is_hotel => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def tour_operators
     @users = User.where(:is_tour_operator => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def tour_agencies
     @users = User.where(:is_tour_agency => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def recreation_centers
     @users = User.where(:is_recreation_center => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def sanatorium
     @users = User.where(:is_sanatorium => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def hostel
     @users = User.where(:is_hostel => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def guide
     @users = User.where(:is_guide => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def taxi
     @users = User.where(:is_taxi => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

  def mini_hotels
     @users = User.where(:is_mini_hotel => true)
	 if params[:city_id].present?
	   @users = @users.where(:city_id => params[:city_id])
	 end
    render :action => :index
  end

end
