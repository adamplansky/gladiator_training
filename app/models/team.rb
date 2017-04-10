class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :gym
  has_many :user_teams
  has_many :users, :through => :user_teams

  has_many :challenge_scores
  has_many :challenges, :through => :challenge_scores


  default_scope { order('name') }
  def max_users_in_one_team
    3
  end
  def get_capacity
    "#{self.users.count } / #{max_users_in_one_team}"
  end
  def name_with_gym
    "#{self.name} [#{self.gym.name}]"
  end

end
