class Country < ActiveRecord::Base
  if Rails.env.production?
      self.per_page = 20
    else
      self.per_page = 2
    end
  has_one :embassy
  has_many :turs
  has_many :user_countries
  has_many :stends
  has_many :directions
  has_one :visa
  has_one :phrasebook
  has_one :memo
  has_many :journals

  has_many :tenders
  has_many :reports

  scope :in_list, where(:in_list => true) #where(:published => true)
  default_scope :order => 'title'
  accepts_nested_attributes_for :embassy
  accepts_nested_attributes_for :visa
  accepts_nested_attributes_for :phrasebook
  accepts_nested_attributes_for :memo

  has_attached_file :flag, :styles => {:small => "100x100>", :medium => "300x300>", :thumb=> "68x38>", :mini=> "20>"},
                    :url  => "/system/assets/countries/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/countries/:id/:style/:basename.:extension"

  validates_attachment_presence :flag
  validates_attachment_size :flag, :less_than => 5.megabytes
  validates_attachment_content_type :flag, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :image1, :styles => {:small => "250x250>", :medium => "300x300>"},
                    :url  => "/system/assets/countries/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/countries/:id/:style/:basename.:extension"

  validates_attachment_presence :image1
  validates_attachment_size :image1, :less_than => 5.megabytes
  validates_attachment_content_type :image1, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :image2, :styles => {:small => "250x250>", :medium => "300x300>"},
                    :url  => "/system/assets/countries/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/countries/:id/:style/:basename.:extension"

  validates_attachment_presence :image2
  validates_attachment_size :image2, :less_than => 5.megabytes
  validates_attachment_content_type :image2, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :image3, :styles => {:small => "250x250>", :medium => "300x300>"},
                    :url  => "/system/assets/countries/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/countries/:id/:style/:basename.:extension"

  validates_attachment_presence :image3
  validates_attachment_size :image3, :less_than => 5.megabytes
  validates_attachment_content_type :image3, :content_type => ['image/jpeg', 'image/png', 'image/gif']

def previous
  self.class.first(:conditions => ["id < ?", id], :order => "id desc")
end

def next
  self.class.first(:conditions => ["id > ?", id], :order => "id asc")
end
end
