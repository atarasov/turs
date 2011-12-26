class Company::FinanceController < ApplicationController
  before_filter :login_required, :except => [:update_invoice]
  def new
	@balance = Balance.new
	if params[:sum].present?
	  @balance.sum = params[:sum].to_i
	end
  end

  def create
	if params[:balance][:sum].to_i > 0
		@balance = Balance.create(:user_id => current_user.id, :sum => params[:balance][:sum], :is_confirmed => false, :comment => "Пополнение счета пользователя", :is_ingoing => true)
		mrh_login = "romchik911"
		mrh_pass1 = "q1w2e3r4"
		mrh_pass2 = "r4e3w2q1"

		# номер заказа
		inv_id = @balance.id

		# описание заказа
		inv_desc = "Пополнение баланса пользователя #{current_user.id}"

		# сумма заказа
		out_summ = @balance.sum

		# тип товара
		shp_item = "1";

		# язык
		culture = "ru";

		# кодировка
		encoding = "utf-8";

		# формирование подписи
		crc  = Digest::MD5.hexdigest("#{mrh_login}:#{out_summ}:#{inv_id}:#{mrh_pass1}:Shp_item=#{shp_item}");

		#url
		# рабочий:
		#https://merchant.roboxchange.com/Index.aspx
		url = "http://test.robokassa.ru"

		pay_params = URI.escape("MrchLogin=#{mrh_login}&OutSum=#{out_summ}&InvId=#{inv_id}" +
			         "&Desc=#{inv_desc}&SignatureValue=#{crc}&Shp_item=#{shp_item}" +
			         "&Culture=#{culture}&Encoding=#{encoding}")
	  #Генерируем урлу и перехъодим по ней

	  	redirect_to url + "?" + pay_params
	else
	  @balance = Balance.new
	  flash[:notice] = "Неверная сумма"
	  render :action => :new
	end

  end

  def pay_successful
	@balance = Balance.where(:id => params[:InvId], :is_confirmed => true).first
	if @balance.present? #TODO проверка хэша
		mrh_login = "romchik911"
		mrh_pass1 = "q1w2e3r4"
		mrh_pass2 = "r4e3w2q1"

		# номер заказа
		inv_id = @balance.id

		# сумма заказа
		out_summ = @balance.sum

		# тип товара
		shp_item = "1";

		# язык
		culture = "ru";

		# кодировка
		encoding = "utf-8";
		my_crc = Digest::MD5.hexdigest("#{out_summ}:#{inv_id}:#{mrh_pass1}:Shp_item=#{shp_item}").upcase
		they_crc = params[:SignatureValue].upcase
		params_crc = Digest::MD5.hexdigest("#{params[:OutSum]}:#{params[:InvId]}:#{mrh_pass1}:Shp_item=#{params[:Shp_item]}").upcase

		if (my_crc == they_crc) && (they_crc == params_crc)
	  		flash[:notice] = "Платёж успешен"
		end

		redirect_to :controller => "company/profiles", :action => :show, :id => @balance.user_id
	else
	  redirect_to root_url
	end

  end

  def pay_declined
	@balance = Balance.where(:id => params[:InvId], :is_confirmed => false).first
	if @balance.present? #TODO проверка хэша
		mrh_login = "romchik911"
		mrh_pass1 = "q1w2e3r4"
		mrh_pass2 = "r4e3w2q1"

		# номер заказа
		inv_id = @balance.id

		# сумма заказа
		out_summ = @balance.sum

		# тип товара
		shp_item = "1";

		# язык
		culture = "ru";

		# кодировка
		encoding = "utf-8";
		my_crc = Digest::MD5.hexdigest("#{out_summ}:#{inv_id}:#{mrh_pass1}:Shp_item=#{shp_item}").upcase
		they_crc = params[:SignatureValue].upcase
		params_crc = Digest::MD5.hexdigest("#{params[:OutSum]}:#{params[:InvId]}:#{mrh_pass1}:Shp_item=#{params[:Shp_item]}").upcase

		if (my_crc == they_crc) && (they_crc == params_crc)

		  	@balance.destroy
	  		flash[:notice] = "Платёж отменен"
		end

		redirect_to :controller => "company/profiles", :action => :show, :id => @balance.user_id
	else
	  redirect_to root_url
	end
  end

  def update_invoice
	@balance = Balance.where(:id => params[:InvId], :is_confirmed => false, :is_ingoing => true).first

	if @balance.present?
		mrh_login = "romchik911"
		mrh_pass1 = "q1w2e3r4"
		mrh_pass2 = "r4e3w2q1"

		# номер заказа
		inv_id = @balance.id

		# сумма заказа
		out_summ = @balance.sum

		# тип товара
		shp_item = "1";

		# язык
		culture = "ru";

		# кодировка
		encoding = "utf-8";
		my_crc = Digest::MD5.hexdigest("#{out_summ}:#{inv_id}:#{mrh_pass2}:Shp_item=#{shp_item}").upcase
		they_crc = params[:SignatureValue].upcase
		params_crc = Digest::MD5.hexdigest("#{params[:OutSum]}:#{params[:InvId]}:#{mrh_pass2}:Shp_item=#{params[:Shp_item]}").upcase
		if (my_crc == they_crc) && (they_crc == params_crc)
			@balance.is_confirmed = true
	  		@balance.save
	  		render :text => "OK#{params[:InvId]}"
		else
		  render :text => "Bad sign"
		end
	else
	  render :text => "Bad sign"
	end

  end

  def destroy

  end

  def index
	@billings = Balance.where(:user_id => current_user.id)
  end
end
