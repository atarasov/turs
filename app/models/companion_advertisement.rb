class CompanionAdvertisement < ActiveRecord::Base
  belongs_to :user
  belongs_to :city, :foreign_key => "from_city"
end
