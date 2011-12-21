class Company::BaseController < ApplicationController
  layout "company"
  before_filter :profile_find, :except => [:accept_command_call, :show_pic, :show_crop]
  
  #before_filter :authenticate_user!
   def profile_find
     if params[:profile_id]
       @profile = User.find(params[:profile_id])
     else
       @profile = User.find(params[:id])
     end
     if params[:user_id]
       @profile = User.find(params[:user_id])
     end
   end

end
