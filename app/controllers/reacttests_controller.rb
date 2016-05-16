class ReacttestsController < ApplicationController
  before_action :set_reacttest, only: [:show, :edit, :update, :destroy]

  # GET /reacttests
  # GET /reacttests.json
  def index
    @reacttests = Reacttest.all
  end

  # GET /reacttests/1
  # GET /reacttests/1.json
  def show
  end

  # GET /reacttests/new
  def new
    @reacttest = Reacttest.new
  end

  # GET /reacttests/1/edit
  def edit
  end

  # POST /reacttests
  # POST /reacttests.json
  def create
    @reacttest = Reacttest.new(reacttest_params)

    respond_to do |format|
      if @reacttest.save
        format.html { redirect_to @reacttest, notice: 'Reacttest was successfully created.' }
        format.json { render :show, status: :created, location: @reacttest }
      else
        format.html { render :new }
        format.json { render json: @reacttest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reacttests/1
  # PATCH/PUT /reacttests/1.json
  def update
    respond_to do |format|
      if @reacttest.update(reacttest_params)
        format.html { redirect_to @reacttest, notice: 'Reacttest was successfully updated.' }
        format.json { render :show, status: :ok, location: @reacttest }
      else
        format.html { render :edit }
        format.json { render json: @reacttest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reacttests/1
  # DELETE /reacttests/1.json
  def destroy
    @reacttest.destroy
    respond_to do |format|
      format.html { redirect_to reacttests_url, notice: 'Reacttest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reacttest
      @reacttest = Reacttest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reacttest_params
      params[:reacttest]
    end
end
