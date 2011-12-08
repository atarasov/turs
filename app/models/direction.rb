class Direction < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
end
