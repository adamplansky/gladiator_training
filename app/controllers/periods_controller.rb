class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :logged_in_user

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.all
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
  end

  # GET /periods/new
  def new
    @period = Period.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      logger.debug "@period.update(period_params): #{period_params}"
      if @period.update(period_params)
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @period }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:time_from, :time_to, :name, :time_from_1, :time_from_2, :time_from_3, :time_to_1, :time_to_2, :time_to_3)
    end
end
