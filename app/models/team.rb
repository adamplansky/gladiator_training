class Team < ActiveRecord::Base
  belongs_to :user

  has_many :user_teams
  has_many :users, :through => :user_teams

  default_scope { order('name') }
  def max_users_in_one_team
    3
  end
  def get_capacity
    "#{self.users.count } / #{max_users_in_one_team}"
  end
end
