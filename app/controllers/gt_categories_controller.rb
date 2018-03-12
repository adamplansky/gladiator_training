class GtCategoriesController < ApplicationController
  before_action :set_gt_category, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:create, :new, :edit, :update, :destroy]
  # GET /gt_categories
  # GET /gt_categories.json
  def index
    @gt_categories = GtCategory.all
  end

  # GET /gt_categories/1
  # GET /gt_categories/1.json
  def show
  end

  # GET /gt_categories/new
  def new
    @gt_category = GtCategory.new
  end

  # GET /gt_categories/1/edit
  def edit
  end

  # POST /gt_categories
  # POST /gt_categories.json
  def create
    @gt_category = GtCategory.new(gt_category_params)

    respond_to do |format|
      if @gt_category.save
        format.html { redirect_to @gt_category, notice: 'Gt category was successfully created.' }
        format.json { render :show, status: :created, location: @gt_category }
      else
        format.html { render :new }
        format.json { render json: @gt_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gt_categories/1
  # PATCH/PUT /gt_categories/1.json
  def update
    respond_to do |format|
      if @gt_category.update(gt_category_params)
        format.html { redirect_to @gt_category, notice: 'Gt category was successfully updated.' }
        format.json { render :show, status: :ok, location: @gt_category }
      else
        format.html { render :edit }
        format.json { render json: @gt_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gt_categories/1
  # DELETE /gt_categories/1.json
  def destroy
    @gt_category.destroy
    respond_to do |format|
      format.html { redirect_to gt_categories_url, notice: 'Gt category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gt_category
      @gt_category = GtCategory.find(params[:id])
    end
    def set_gt_race
      @gt_race = GtRace.find(params[:gt_race_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gt_category_params
      params.require(:gt_category).permit(:name, :single, :description)
    end
end
