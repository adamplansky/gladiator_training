class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  default_scope -> { order('created_at asc') }
  
  before_create :set_registration_time_to_now
  def set_registration_time_to_now
    self.registration_time = Time.now
  end
end
