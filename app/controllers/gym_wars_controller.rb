class GymWarsController < ApplicationController
  layout 'gymwars'
  before_action :set_gym_war, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:show, :edit, :update, :destroy]
  # GET /gym_wars
  # GET /gym_wars.json
  def index
    @gym_war = GymWar.all.first
  end

  # GET /gym_wars/1
  # GET /gym_wars/1.json
  def show
  end

  # GET /gym_wars/new
  def new
    @gym_war = GymWar.new
  end

  # GET /gym_wars/1/edit
  def edit
  end

  # POST /gym_wars
  # POST /gym_wars.json
  def create
    return if GymWar.all.count > 1
    @gym_war = GymWar.new(gym_war_params)

    respond_to do |format|
      if @gym_war.save
        format.html { redirect_to gym_wars_path, notice: 'Gym war was successfully created.' }
        format.json { render :show, status: :created, location: @gym_war }
      else
        format.html { render :new }
        format.json { render json: @gym_war.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gym_wars/1
  # PATCH/PUT /gym_wars/1.json
  def update
    respond_to do |format|
      if @gym_war.update(gym_war_params)
        format.html { redirect_to gym_wars_path, notice: 'Gym war was successfully updated.' }
        format.json { render :show, status: :ok, location: @gym_war }
      else
        format.html { render :edit }
        format.json { render json: @gym_war.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gym_wars/1
  # DELETE /gym_wars/1.json
  # def destroy
  #   @gym_war.destroy
  #   respond_to do |format|
  #     format.html { redirect_to gym_wars_url, notice: 'Gym war was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym_war
      @gym_war = GymWar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gym_war_params
      params.require(:gym_war).permit(:description)
    end
end
