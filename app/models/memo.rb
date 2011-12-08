class Memo < ActiveRecord::Base
  belongs_to :country
  accepts_nested_attributes_for :country
end
