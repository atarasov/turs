class Journal < ActiveRecord::Base
    acts_as_commentable
    
  belongs_to :category
  belongs_to :user
  belongs_to :country
  has_many :journal_photos
  has_many :reports
  #has_many :posts

  cattr_reader :per_page
  @@per_page = 50
end
