class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  # GET /trainings
  # GET /trainings.json
  def index
    @trainings = Training.where(user: current_user)
    @categories = TrainingCategory.all
    @all_my_points = @trainings.map(&:points).reduce(:+)
  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
  end

  # GET /trainings/new
  def new
    @training = Training.new
    @categories = TrainingCategory.all
  end

  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.new(training_params)
    @training.user = current_user
    @category = TrainingCategory.find(params[:training][:training_category_id])
    @training.points = (@category.koef * @training.distance).round(2)
    @training.period = Period.where("time_from < ? AND time_to > ?", Time.now, Time.now).first
    respond_to do |format|
      if @training.save
        format.html { redirect_to @training, notice: 'Training was successfully created.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:training_category_id, :points, :description, :distance)
    end
end
