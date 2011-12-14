class Company::FinanceController < ApplicationController
  def new
	@balance = Balance.new
  end

  def create
	if params[:balance][:sum].to_i > 0
		@balance = Balance.create(:user_id => current_user.id, :sum => params[:balance][:sum], :is_confirmed => false, :comment => "Пополнение счета пользователя")
	  #Генерируем урлу и перехъодим по ней
	  	url = "/" #todo согласовать с аккауном в робокассе
	  	redirect_to url
	else
	  flash[:notice] = "Неверная сумма"
	  redirect_to :action => :index
	end

  end

  def pay_successful
	@balance = Balance.where(:id => params[:InvId]).first
	if true #TODO проверка хэша
	  flash[:notice] = "Платёж успешен"
	end
	redirect_to :actrion => :index
  end

  def pay_declined
	flash[:notice] = "Платежё не проведен"
	redirect_to :actrion => :index
  end

  def update
	@balance = Balance.where(:id => params[:InvId]).first

	if @balance.present? #todo: тут проверяем хэши

	  @balance.is_confirmed = true
	  @balance.save
	  render :text => "OK#{params[:InvId]}"
	else
	  render :text => "Bad sign"
	end

  end

  def destroy

  end

  def index
	@balances.where(:id => current_user.id)
  end
end
