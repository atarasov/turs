class Recommendation < ActiveRecord::Base
  belongs_to :referee, :class_name => "User", :foreign_key => :referee_id
  belongs_to :recommended_user, :class_name => "User", :foreign_key => :recommended_user_id
end
