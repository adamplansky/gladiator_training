class TrainingCategoriesController < ApplicationController
  before_action :set_training_category, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  # GET /training_categories
  # GET /training_categories.json
  def index
    @training_categories = TrainingCategory.all
  end

  # GET /training_categories/1
  # GET /training_categories/1.json
  def show
  end

  # GET /training_categories/new
  def new
    @training_category = TrainingCategory.new
  end

  # GET /training_categories/1/edit
  def edit
  end

  # POST /training_categories
  # POST /training_categories.json
  def create
    @training_category = TrainingCategory.new(training_category_params)

    respond_to do |format|
      if @training_category.save
        format.html { redirect_to @training_category, notice: 'Training category was successfully created.' }
        format.json { render :show, status: :created, location: @training_category }
      else
        format.html { render :new }
        format.json { render json: @training_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_categories/1
  # PATCH/PUT /training_categories/1.json
  def update
    respond_to do |format|
      if @training_category.update(training_category_params)
        format.html { redirect_to @training_category, notice: 'Training category was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_category }
      else
        format.html { render :edit }
        format.json { render json: @training_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_categories/1
  # DELETE /training_categories/1.json
  def destroy
    @training_category.destroy
    respond_to do |format|
      format.html { redirect_to training_categories_url, notice: 'Training category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_category
      @training_category = TrainingCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_category_params
      params.require(:training_category).permit(:name, :koef, :minimum, :description, :units, :image, :points)
    end
end
