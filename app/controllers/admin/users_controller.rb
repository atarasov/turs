class Admin::UsersController < Admin::BaseController
  batch_action(User, {:destroy => :destroy})
  
  def index
    @users = User.all
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml { head :ok }
    end
  end

end
