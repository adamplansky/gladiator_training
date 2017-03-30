class UserTeam < ActiveRecord::Base
  #validates_uniqueness_of :user_id, :scope => :team_id
  belongs_to :team
  belongs_to :user

  before_save :default_values
  def default_values
    if self.user == self.team.user
      self.status ||= Status::Approved
    elsif self.user != self.team.user
      self.status ||= Status::Waiting
    end
  end


end
