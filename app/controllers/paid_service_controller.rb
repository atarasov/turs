class PaidServiceController < ApplicationController
  def index
  end

  def pro
    ProAccount.all
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
    ProAccount.activate(current_user)
  end

  def activate_vip
    VipPlacement.activate(current_user)
  end

  def activate_site_link
    LinkToSite.activate(current_user)
  end

  def activate_recommended
    RecommendedService.activate(current_user)
  end

  def activate_selection
    SelectionService.activate(current_user)
  end

  def activate_in_journal
    JournalService.activate(current_user)
  end

  def activate_advertising_in_site
    InSiteService.activate(current_user)
  end

end
