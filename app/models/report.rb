class Report < ActiveRecord::Base
  belongs_to :user
  has_many :report_photos
  belongs_to :country
  belongs_to :journal
end
