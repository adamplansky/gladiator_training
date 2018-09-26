class GtRacesController < ApplicationController
  layout 'races'
  before_action :set_gt_race, only: [:show, :edit, :update, :destroy]

  # GET /gt_races
  # GET /gt_races.json
  def index
    #redirect_to action: "show", id: GtRace.last.id
    @gt_races = GtRace.where("published > ?", DateTime.now)
  end

  # GET /gt_races/1
  # GET /gt_races/1.json
  def show
     @gt_race = GtRace.find(params[:id])
  end

  # GET /gt_races/new
  def new
    @gt_race = GtRace.new
  end

  # GET /gt_races/1/edit
  def edit
  end

  # POST /gt_races
  # POST /gt_races.json
  def create
    @gt_race = GtRace.new(gt_race_params)
    respond_to do |format|
      if @gt_race.save
        format.html { redirect_to @gt_race, notice: 'Gt race was successfully created.' }
        format.json { render :show, status: :created, location: @gt_race }
      else
        format.html { render :new }
        format.json { render json: @gt_race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gt_races/1
  # PATCH/PUT /gt_races/1.json
  def update
    respond_to do |format|
      if @gt_race.update(gt_race_params)
        format.html { redirect_to @gt_race, notice: 'Gt race was successfully updated.' }
        format.json { render :show, status: :ok, location: @gt_race }
      else
        format.html { render :edit }
        format.json { render json: @gt_race.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gt_races/1
  # DELETE /gt_races/1.json
  def destroy
    @gt_race.destroy
    respond_to do |format|
      format.html { redirect_to gt_races_url, notice: 'Gt race was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gt_race
      @gt_race = GtRace.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def gt_race_params
      params.require(:gt_race).permit(:name, :published, :text, :place, :url, :max_junior_capacity, :max_others_capacity, :registration_end)
    end
end
