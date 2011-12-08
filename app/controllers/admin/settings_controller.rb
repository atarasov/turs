class Admin::SettingsController < Admin::BaseController
  def edit
    @settings = Settings.instance
  end

  def update
    @settings = Settings.instance
    if @settings.update_attributes(params[:settings])
      redirect_to :action => :edit
    else
      render :action => :edit
    end
  end  
end
