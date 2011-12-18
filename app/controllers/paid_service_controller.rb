class PaidServiceController < ApplicationController
  def index
  end

  def pro
    
  end

  def vip
  end

  def site_link
  end

  def recommended
  end

  def selection
  end

  def advertising_in_journal
  end

  def advertising_in_site
  end




  def activate_pro
    #raise current_user.inspect
    ProAccount.activate(current_user)
    redirect_to :action => :pro
  end

  def activate_vip
    VipPlacement.activate(current_user)
    redirect_to :action => :vip
  end

  def activate_site_link
    LinkToSite.activate(current_user)
    redirect_to :action => :site_link
  end

  def activate_recommended
    RecommendedService.activate(current_user)
    redirect_to :action => :recommended
  end

  def activate_selection
    SelectionService.activate(current_user)
    redirect_to :action => :selection
  end

  def activate_journal
    JournalService.activate(current_user)
    redirect_to :action => :advertising_in_journal
  end

  def activate_advertising_in_site
    InSiteService.activate(current_user)
    redirect_to :action => :advertising_in_site
  end

end
