class Service < ActiveRecord::Base
  STATUS = {:active => 1, :not_active => 2, :pending => 3}
end
