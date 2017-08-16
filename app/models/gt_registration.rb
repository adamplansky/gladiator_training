class GtRegistration < ActiveRecord::Base
  validates_email_format_of :email, :message => ' neexistuje!'
  validates :email, :firstname, :surname, presence: true

  belongs_to :gt_race
end
