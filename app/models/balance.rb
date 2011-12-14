class Balance < ActiveRecord::Base
  belongs_to :user

  scope :ingoing, where(:is_ingoing => true)
  scope :outgoing, where(:is_ingoing => false)
  scope :confirmed, where(:is_confirmed => true)
  scope :waite_confirmation, where(:is_confirmed => false)


end
