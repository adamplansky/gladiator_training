class GtRegistrationsController < ApplicationController
  layout 'races'
  include GtRegistrationsHelper
  before_action :set_gt_registration, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:index_with_payed, :edit, :update, :destroy]
  # GET /gt_registrations
  # GET /gt_registrations.json
  def index
    @gt_registrations = GtRegistration.all.where(payed: true)
    @gt_race = GtRace.find(params[:gt_race_id])
  end

  def index_with_payed
    @gt_race = GtRace.find(params[:gt_race_id])
    @gt_registrations = GtRegistration.order(:id)
  end

  # GET /gt_registrations/1
  # GET /gt_registrations/1.json
  def show
  end

  # GET /gt_registrations/new
  def new
    @gt_race = GtRace.find(params[:gt_race_id])
    @gt_registration = @gt_race.gt_registrations.build
    @price = GtPrice.where("DATE(until) >= ?", Date.today ).where(gt_race_id: params[:gt_race_id]).order('until ASC').first.price.to_f
  end

  # GET /gt_registrations/1/edit
  def edit
  end

  # POST /gt_registrations
  # POST /gt_registrations.json
  def create
    @gt_registration = GtRegistration.new(gt_registration_params)
    @gt_race = GtRace.find(params[:gt_race_id])
    respond_to do |format|
      if @gt_registration.save
        format.html { redirect_to [@gt_race,@gt_registration], notice: 'Gt registration was successfully created.' }
        format.json { render :show, status: :created, location: @gt_registration }
        Notifier.race_registration(@gt_registration).deliver_now
        if Rails.env.production?
          Notifier.race_registration_direct(@gt_registration, "adamplansky@seznam.cz,hege8400@seznam.cz,jiricimler@centrum.cz").deliver_now
        end
      else
        puts @race
        format.html { render :new, race: @race  }
        format.json { render json: @gt_registration.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /gt_registrations/1
  # PATCH/PUT /gt_registrations/1.json
  def update
    @gt_race = GtRace.find(params[:gt_race_id])
    respond_to do |format|
      if @gt_registration.update(gt_registration_params)
        format.html { redirect_to index_with_payed_gt_race_gt_registrations_path(@gt_race,@gt_registration), notice: 'Gt registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @gt_registration }
      else
        format.html { render :edit }
        format.json { render json: @gt_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gt_registrations/1
  # DELETE /gt_registrations/1.json
  def destroy
    @gt_registration.destroy
    respond_to do |format|
      format.html { redirect_to index_with_payed_gt_race_gt_registrations_path(@gt_race), notice: 'Gt registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gt_registration
      @gt_registration = GtRegistration.find(params[:id])
      @gt_race = GtRace.find(params[:gt_race_id])
      #@gt_race = GtRace.find(params[:gt_race_id])
      #@price = GtPrice.where("DATE(until) >= ?", Date.today ).where(gt_race_id: params[:gt_race_id]).order('until ASC').first.price.to_f
      #@price = 1
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gt_registration_params
      params.require(:gt_registration).permit(:firstname, :surname, :gt_race_id, :price, :street, :city, :psc, :phone_number, :code, :birth, :sex, :notes, :email, :team, :payed)
    end
end
