class Mention < ActiveRecord::Base
  has_attached_file :avatar, :styles => {:small => "64x64", :medium => "150x150", :thumbnail => "30x30"},
                    :url  => "/system/assets/mentions/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/mentions/:id/:style/:basename.:extension",
                    :default_url => "/images/avatar.jpg"

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/pjpeg']
end
