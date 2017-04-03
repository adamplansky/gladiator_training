class ChallengesController < ApplicationController
  require "date"
  require "youtube_addy"

  layout "gymwars"
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:new, :create,  :edit, :update, :destroy]

  # GET /challenges
  # GET /challenges.json
  def index
    @actual_challenges = Challenge.actual_challenges
    puts "@actual_challenges #{@actual_challenges}"
    @challenges = Challenge.all - @actual_challenges
  end


  # GET /challenges/1
  # GET /challenges/1.json
  def show
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)


    @challenge.season = Season.where("from_time < ? AND to_time > ?", DateTime.now, DateTime.now).first
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def leaderboard
    @challenges = Challenge.all
    @users = User.all
    @challenge_ary = []
    @challenges.each do |challenge|
      @challenge_ary << {
        challenge: challenge,
        male: Pgdb.get_points_gyms_wars(Gender::Male, challenge.id),
        female: Pgdb.get_points_gyms_wars(Gender::Female, challenge.id),
      }

    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challenge_params
    params.require(:challenge).permit(:url, :name, :description, :from_time, :to_time, :challenge_category_id)
  end
end
