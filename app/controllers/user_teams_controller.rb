class UserTeamsController < ApplicationController

  # GET /user_teams
  # GET /user_teams.json
  def index
    @user_teams = UserTeam.all
  end

  # GET /user_teams/1
  # GET /user_teams/1.json
  def show
  end

  # GET /user_teams/new
  def new
    @user_team = UserTeam.new
  end

  # GET /user_teams/1/edit
  def edit
  end

  # POST /user_teams
  # POST /user_teams.json
  def create
    @user_team = UserTeam.new(user_team_params)

    respond_to do |format|
      if @user_team.save
        #format.html { redirect_to @user_team, notice: 'User team was successfully created.' }
        #format.json {} #render :show, status: :created, location: @user_team }
        format.html { redirect_to teams_path, notice: 'Požádavek odeslán.' }

      else
        format.html { render :new }
        format.json { render json: @user_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_teams/1
  # PATCH/PUT /user_teams/1.json
  def update
    @user_team = UserTeam.where(user: params[:user_team][:user_id], team: params[:user_team][:team_id]).first
    @user_team.status = params[:user_team][:status]
    respond_to do |format|
      if @user_team.save
        format.html { redirect_to teams_path, notice: 'User team was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_team }
      else
        format.html { render :edit }
        format.json { render json: @user_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_teams/1
  # DELETE /user_teams/1.json
  def destroy
    t = Team.find(params[:user_team][:team_id])
    u = User.find(params[:user_team][:user_id])
    if params[:user_team][:user_id].to_i == current_user.id || t.user_id == current_user.id
      t.users.delete(u)
    end
    respond_to do |format|
      format.html { redirect_to teams_path, notice: 'Uživatel již není v týmu.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_team_params
      params.require(:user_team).permit(:user_id, :team_id, :status)
    end
end
