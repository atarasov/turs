class Service < ActiveRecord::Base
  belongs_to :user
  STATUS = {:active => 1, :not_active => 2, :pending => 3}
end
