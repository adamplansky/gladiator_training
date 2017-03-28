class ChallengeScoresController < ApplicationController
  layout 'gymwars'
  before_action :set_challenge_score, only: [:show, :edit, :update, :destroy]

  # GET /challenge_scores
  # GET /challenge_scores.json
  def index
    @challenge_scores = ChallengeScore.all
  end

  # GET /challenge_scores/1
  # GET /challenge_scores/1.json
  def show
  end

  # GET /challenge_scores/new
  def new
    redirect_to challenges_path unless params[:format]
    @challenge = Challenge.find(params[:format])
    redirect_to challenges_path unless @challenge
    redirect_to edit_user_path(current_user), :flash => { :error => "Je nutné vyplnit GYM" } unless current_user.gym
    @challenge_score = ChallengeScore.new
  end

  # GET /challenge_scores/1/edit
  def edit
  end

  # POST /challenge_scores
  # POST /challenge_scores.json
  def create
    @challenge_score = ChallengeScore.new(challenge_score_params)
    @challenge_score.user = current_user
    @challenge = Challenge.find(params[:challenge_score][:challenge_id])
    respond_to do |format|
      if @challenge_score.save
        format.html { redirect_to @challenge_score, notice: 'Challenge score was successfully created.' }
        format.json { render :show, status: :created, location: @challenge_score }
      else
        format.html { render :new }
        format.json { render json: @challenge_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenge_scores/1
  # PATCH/PUT /challenge_scores/1.json
  def update
    respond_to do |format|
      if @challenge_score.update(challenge_score_params)
        format.html { redirect_to @challenge_score, notice: 'Challenge score was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge_score }
      else
        format.html { render :edit }
        format.json { render json: @challenge_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_scores/1
  # DELETE /challenge_scores/1.json
  def destroy
    @challenge_score.destroy
    respond_to do |format|
      format.html { redirect_to challenge_scores_url, notice: 'Challenge score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge_score
      @challenge_score = ChallengeScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_score_params
      params.require(:challenge_score).permit(:challenge_time, :url, :user_id, :challenge_id, :gym_id)
    end
end