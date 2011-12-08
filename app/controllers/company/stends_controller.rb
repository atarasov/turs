class Company::StendsController < Company::BaseController

  def edit
    @countries = Country.all
    @stend = Stend.where(:user_id=>params[:id])
  end
  
  def update
    params[:stends].each do |stend|
      if stend[id]
        Stend.update(stend[id], stend)
      else
        Stend.create(stend)
      end
    end
    redirect_to :action => :edit
  end

  def create
    params[:stends].each do |stend|
      #raise stend.inspect
      if stend[id]
        Stend.update(stend[id], stend)
      else
        Stend.create(stend)
      end
    end
    redirect_to :action => :edit
  end
end
