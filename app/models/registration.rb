class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  default_scope -> { order('created_at asc') }
  validate :now_is_greater_then_registration_end
  before_create :set_registration_time_to_now
  def set_registration_time_to_now
    self.registration_time = Time.now
  end

  def now_is_greater_then_registration_end
    if self.event.registration_end < DateTime.now
      errors.add(:base, "Registrace byly uzavřeny.")
    end
  end

end
