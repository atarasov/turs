module Company::BaseHelper
  def custom_img_tag(upload, width, height, id)
      if width > User::MAX_CROP_WIDTH
        image_tag upload.picture.url(:original), :id => id, :width => User::MAX_CROP_WIDTH, :height => (height*User::MAX_CROP_WIDTH/width).to_i
      else
        image_tag upload.picture.url(:original), :id => id
      end
    end

end
