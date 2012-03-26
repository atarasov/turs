class FavoriteUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :preferred_user, :class_name => "User"

end
