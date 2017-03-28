class ChallengeLeaderboardsController < ApplicationController
  layout "gymwars"
  before_action :set_challenge, only: [:men, :women, :gyms, :mixes]
  def index
    render plain: "ChallengeLeaderboardsController"
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

  end

  private
  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
    @users = User.all
    @gyms = Gym.all
  end
  # @challenges = Challenge.all
  # @users = User.all
  # @challenge_ary = []
  # @challenges.each do |challenge|
  #   @challenge_ary << {
  #     challenge: challenge,
  #     male: Pgdb.get_points_gyms_wars(Gender::Male, challenge.id),
  #     female: Pgdb.get_points_gyms_wars(Gender::Female, challenge.id),
  #   }
  #
  # end
end
