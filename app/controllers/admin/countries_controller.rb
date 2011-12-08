class Admin::CountriesController < Admin::BaseController
  batch_action(Country, {:destroy => :destroy})
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  def index
    @countries = Country.all
  end

  # GET /countries/new
  # GET /countries/new.xml
  def new
    @country = Country.new
    @country.visa = Visa.new
    @country.memo = Memo.new
    @country.embassy = Embassy.new
    @country.phrasebook = Phrasebook.new
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
    @country.visa = Visa.new unless @country.visa
    @country.memo = Memo.new unless @country.memo
    @country.embassy = Embassy.new unless @country.embassy
    @country.phrasebook = Phrasebook.new unless @country.phrasebook
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    @country.visa = Visa.new(params[:country][:visa])
    @country.memo = Memo.new(params[:country][:memo])
    @country.embassy = Embassy.new(params[:country][:embassy])
    @country.phrasebook = Phrasebook.new(params[:country][:phrasebook])

    if @country.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end

  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])
    @country.visa.attributes = params[:country][:visa]
    @country.memo.attributes = params[:country][:memo]
    @country.embassy.attributes = params[:country][:embassy]
    @country.phrasebook.attributes = params[:country][:phrasebook]
    if @country.update_attributes(params[:country])
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.xml
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to(countries_url) }
      format.xml { head :ok }
    end
  end
end