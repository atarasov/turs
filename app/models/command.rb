class Command < ActiveRecord::Base
  belongs_to :leader, :class_name => "User", :foreign_key => :leader_id
  belongs_to :member, :class_name => "User", :foreign_key => :member_id
end
