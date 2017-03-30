class LeaderboardsController < ApplicationController
  layout "gymwars"
  before_action :set_leaderboard, only: [:show, :edit, :update, :destroy]
  before_action :set_leaderboard

  def index
    @data_set = Pgdb.get_full_leaderboard_gyms_wars(@season.id)
  end
  def men
    @data_set = Pgdb.get_full_leaderboard_men_gyms_wars(@season.id)
  end

  def women
    @data_set = Pgdb.get_full_leaderboard_women_gyms_wars(@season.id)
  end

  def gyms
    @data_set = Pgdb.get_full_leaderboard_gyms_wars(@season.id)
  end

  def mixes
    @data_set = Pgdb.get_full_leaderboard_mixes_gyms_wars(@season.id)
  end


  def show
  end

  # GET /leaderboards/new
  def new
    @leaderboard = Leaderboard.new
  end

  # GET /leaderboards/1/edit
  def edit
  end

  # POST /leaderboards
  # POST /leaderboards.json
  def create
    @leaderboard = Leaderboard.new(leaderboard_params)

    respond_to do |format|
      if @leaderboard.save
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully created.' }
        format.json { render :show, status: :created, location: @leaderboard }
      else
        format.html { render :new }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaderboards/1
  # PATCH/PUT /leaderboards/1.json
  def update
    respond_to do |format|
      if @leaderboard.update(leaderboard_params)
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @leaderboard }
      else
        format.html { render :edit }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaderboards/1
  # DELETE /leaderboards/1.json
  def destroy
    @leaderboard.destroy
    respond_to do |format|
      format.html { redirect_to leaderboards_url, notice: 'Leaderboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaderboard
      @season = Season.find(params[:season_id])
      @users = User.all
      @gyms = Gym.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leaderboard_params
      params[:leaderboard]
    end
end
