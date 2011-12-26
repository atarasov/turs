class JournalPhoto < ActiveRecord::Base
  belongs_to :journal

  has_attached_file :image, :styles => {:small => "250x250>", :large => "700x700>", :thumbnail => "60x60#", :middle => "360x345>"},
                    :url  => "/system/assets/facility_photos/images/:id_partition/:style_:id.:extension",
                    :path => ":rails_root/public/system/assets/facility_photos/images/:id_partition/:style_:id.:extension"

  #validates_attachment_presence :avatar
  validates_attachment_size :image, :less_than => 10.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/pjpeg']
end
