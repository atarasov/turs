class Favorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :favorite, :class_name => "User", :foreign_key => :favorite_id
end
