class InSiteService < Service

  @expire_periud = 1.month
  @price = 1000
  @type_service = 'InSiteService'

  def self.activate(user)
    @is_test = self.where(:user_id => user.id).size > 0 ? false : true
    if user.get_balance > @price && !@is_test
      Service.create(:user_id => user.id,
                     :expire_date => Time.now + @expire_periud,
                     :amount => @price,
                     :service_type => @type_service,
                     :is_test => @is_test,
                     :status => Service::STATUS[:active]

      )
    elsif user.get_balance < @price && !@is_test
      Service.create(:user_id => user.id,
                     :expire_date => Time.now + @expire_periud,
                     :amount => @price,
                     :service_type => @type_service,
                     :is_test => @is_test,
                     :status => Service::STATUS[:pending]

      )
    else
      Service.create(:user_id => user.id,
                     :expire_date => Time.now + @expire_periud,
                     :amount => @price,
                     :service_type => @type_service,
                     :is_test => @is_test,
                     :status => Service::STATUS[:active]

      )
    end
  end

  def balance_write_down user
    user
  end

  def self.activated(user)
      self.where("status = ? AND user_id = ?" ,Service::STATUS[:active], user.id).size > 0 ? true : false
  end

  default_scope where :service_type => @type_service
  
end