class ConsultantsController < ApplicationController
  def index
	@users = User.consultant
	@vips = VipPlacement.where("status = ? " ,Service::STATUS[:active]).group(:user_id)
	render :file => "catalog/index"
  end
end
