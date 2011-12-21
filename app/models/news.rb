class News < ActiveRecord::Base
  has_attached_file :image, :styles => {:small => "64x64", :medium => "150x150", :thumbnail => "30x30"},
                    :url  => "/system/assets/news/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/news/:id/:style/:basename.:extension",
                    :default_url => "/images/avatar.jpg"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/pjpeg']
end
