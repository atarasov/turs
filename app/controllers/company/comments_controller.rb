class Company::CommentsController < Company::BaseController
  uses_tiny_mce(:options => AppConfig.for_comment_mce_options, :only => [:index])
  before_filter :login_required, :only => :add_comment

  def index
    @user = User.find(params[:id])
    @comments = @user.comments.recent.all
  end

  def add_comment
    @user = User.find(params[:id])
    @user.comments.create(:comment => params[:comment][:text])
    redirect_to :action => :index, :id => params[:id]
  end
end
