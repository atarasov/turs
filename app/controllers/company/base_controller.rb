class Company::BaseController < ApplicationController
  layout "company"
  before_filter :profile_find
  
  #before_filter :authenticate_user!
   def profile_find
     @profile = User.find(params[:id]) if params[:id]
   end

end
