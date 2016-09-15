class TrainingsController < ApplicationController
  layout 'subapplication'
  before_action :set_training, only: [:show, :edit, :update, :destroy, :edit_super, :update_super]
  before_action :logged_in_user
  # GET /trainings
  # GET /trainings.json
  def index
    @trainings = Training.all.page(params[:page])
    #@all_my_points = @trainings.map(&:points).reduce(:+).try(:round,2)
    @categories = TrainingCategory.all
  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
    # @training = Training.find(user: current_user)
    # @categories = TrainingCategory.all
    # @all_my_points = @trainings.map(&:points).reduce(:+)
  end

  # GET /trainings/new
  def new
    @training = Training.new
    @categories = TrainingCategory.all
  end

  def update_super

    @training.update(training_params)
    @training.period = Period.where("time_from < ? AND time_to > ?", @training.created_at, @training.created_at).first
    respond_to do |format|
      if @training.save
        format.html { redirect_to trainings_url, notice: 'Training was successfully created.' }
        format.json { render :index, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit_super

  end

  # POST /trainings
  # POST /trainings.json
  def create
    puts "training_params: #{training_params}"
    @training = Training.new(training_params)
    @training.user = current_user
    reg = /(\d{1,2}).(\d{1,2}).(\d{0,4})/.match(@training.description)
    @training.created_at = DateTime.new(reg[3].empty? ? DateTime.now.year : reg[3].to_i, reg[2].to_i,reg[1].to_i) if reg

    @category = TrainingCategory.find(params[:training][:training_category_id])
    if @category.minimum > (@training.distance || 0)
      @training.points = 0
    else
      @training.points = (@category.koef * (@training.distance || 0)).try(:round,2)
    end

    @training.points = @category.points if @category.koef == 0
    @training.period = Period.where("time_from < ? AND time_to > ?", Time.now, Time.now).first
    respond_to do |format|
      if @training.save
        format.html { redirect_to trainings_url, notice: 'Training was successfully created.' }
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
      format.html { redirect_to current_user, notice: 'Training was successfully destroyed.' }
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
      params.require(:training).permit(:training_category_id, :points, :description, :distance, :created_at)
    end
end
