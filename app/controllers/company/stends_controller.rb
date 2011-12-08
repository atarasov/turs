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

    if !params[:stends][:stend1_id].eql?("")
      Stend.update(params[:stends][:stend1_id], params[:stends][:stend1])
    else
      Stend.create(params[:stends][:stend1])
    end

    if !params[:stends][:stend2_id].eql?("")
      Stend.update(params[:stends][:stend2_id], params[:stends][:stend2])
    else
      Stend.create(params[:stends][:stend2])
    end

    if !params[:stends][:stend3_id].eql?("")
      Stend.update(params[:stends][:stend3_id], params[:stends][:stend3])
    else
      Stend.create(params[:stends][:stend3])
    end

    if !params[:stends][:stend4_id].eql?("")
      Stend.update(params[:stends][:stend4_id], params[:stends][:stend4])
    else
      Stend.create(params[:stends][:stend4])
    end

    if !params[:stends][:stend5_id].eql?("")
      Stend.update(params[:stends][:stend5_id], params[:stends][:stend5])
    else
      Stend.create(params[:stends][:stend5])
    end

    redirect_to :action => :edit
  end
end
