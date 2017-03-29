class ChallengeCategoriesController < ApplicationController
  layout 'gymwars'
  before_action :set_challenge_category, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin
  # GET /challenge_categories
  # GET /challenge_categories.json
  def index
    @challenge_categories = ChallengeCategory.all
  end

  # GET /challenge_categories/1
  # GET /challenge_categories/1.json
  def show
  end

  # GET /challenge_categories/new
  def new
    @challenge_category = ChallengeCategory.new
  end

  # GET /challenge_categories/1/edit
  def edit
  end

  # POST /challenge_categories
  # POST /challenge_categories.json
  def create
    @challenge_category = ChallengeCategory.new(challenge_category_params)

    respond_to do |format|
      if @challenge_category.save
        format.html { redirect_to @challenge_category, notice: 'Challenge category was successfully created.' }
        format.json { render :show, status: :created, location: @challenge_category }
      else
        format.html { render :new }
        format.json { render json: @challenge_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenge_categories/1
  # PATCH/PUT /challenge_categories/1.json
  def update
    respond_to do |format|
      if @challenge_category.update(challenge_category_params)
        format.html { redirect_to @challenge_category, notice: 'Challenge category was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge_category }
      else
        format.html { render :edit }
        format.json { render json: @challenge_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_categories/1
  # DELETE /challenge_categories/1.json
  def destroy
    @challenge_category.destroy
    respond_to do |format|
      format.html { redirect_to challenge_categories_url, notice: 'Challenge category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge_category
      @challenge_category = ChallengeCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_category_params
      params.require(:challenge_category).permit(:name)
    end
end
