class RecommendedService < Service

  @@expire_periud = 1.month
  @@price = 1000
  @@type_service = 'RecommendedService'

  def self.activate(user)
    @is_test = self.where(:user_id => user.id).size > 0 ? false : true
    if user.get_balance > self.price && !@is_test
      Service.create(:user_id => user,
                     :expire_date => Time.now + self.expire_periud,
                     :amount => self.price,
                     :service_type => self.type_service,
                     :is_test => @is_test,
                     :status => Service::STATUS[:active]

      )
    elsif user.get_balance < self.price && !@is_test
      Service.create(:user_id => user,
                     :expire_date => Time.now + self.expire_periud,
                     :amount => self.price,
                     :service_type => self.type_service,
                     :is_test => @is_test,
                     :status => Service::STATUS[:pending]

      )
    else
      Service.create(:user_id => user,
                     :expire_date => Time.now + self.expire_periud,
                     :amount => self.price,
                     :service_type => self.type_service,
                     :is_test => @is_test,
                     :status => Service::STATUS[:active]

      )
    end
  end

  def balance_write_down user
    user
  end

  default_scope where :service_type => self.type_service

end