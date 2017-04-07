class ChallengeLeaderboardsController < ApplicationController
  layout "gymwars"
  before_action :set_challenge, only: [:men, :women, :gyms, :mixes, :index]
  def index
    @data_set = Pgdb.get_gym_points_gyms_wars(@challenge.id)
  end

  def men
      @data_set = Pgdb.get_points_gyms_wars(Gender::Men,@challenge.id)
  end

  def women
    @data_set = Pgdb.get_points_gyms_wars(Gender::Women,@challenge.id)
  end

  def gyms
    @data_set = Pgdb.get_gym_points_gyms_wars(@challenge.id)
  end

  def mixes
    @data_set = Pgdb.get_points_mixes_gyms_wars(@challenge.id)
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
    @users = User.all
    @gyms = Gym.all
    @teams = Team.all
  end
end
