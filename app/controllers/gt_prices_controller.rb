class GtPricesController < ApplicationController
  layout 'races'
  before_action :set_gt_price, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin

  # GET /gt_prices
  # GET /gt_prices.json
  def index
    @gt_prices = GtPrice.all
  end

  # GET /gt_prices/1
  # GET /gt_prices/1.json
  def show
  end

  # GET /gt_prices/new
  def new
    @gt_race = params[:format]#new_gt_price_path(@gt_race)
    @gt_price = GtPrice.new
  end

  # GET /gt_prices/1/edit
  def edit
  end

  # POST /gt_prices
  # POST /gt_prices.json
  def create
    @gt_price = GtPrice.new(gt_price_params)

    respond_to do |format|
      if @gt_price.save
        format.html { redirect_to gt_race_path(@gt_price.gt_race_id), notice: 'Gt price was successfully created.' }
        format.json { render :show, status: :created, location: @gt_price }
      else
        format.html { render :new }
        format.json { render json: @gt_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gt_prices/1
  # PATCH/PUT /gt_prices/1.json
  def update
    respond_to do |format|
      if @gt_price.update(gt_price_params)
        format.html { redirect_to @gt_price, notice: 'Gt price was successfully updated.' }
        format.json { render :show, status: :ok, location: @gt_price }
      else
        format.html { render :edit }
        format.json { render json: @gt_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gt_prices/1
  # DELETE /gt_prices/1.json
  def destroy
    @gt_price.destroy
    respond_to do |format|
      format.html { redirect_to gt_prices_url, notice: 'Gt price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gt_price
      @gt_price = GtPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gt_price_params
      params.require(:gt_price).permit(:until, :gt_race_id, :price)
    end
end
