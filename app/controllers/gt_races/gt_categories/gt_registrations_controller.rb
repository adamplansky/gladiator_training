class GtRaces::GtCategories::GtRegistrationsController < ApplicationController
  layout 'races'
  include GtRegistrationsHelper
  before_action :set_gt_registration, only: [:show, :edit, :update, :destroy]
  before_action :set_gt_race, only: [:sendgrid, :index_with_payed, :index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_gt_guide_category, only: [:index_with_payed, :index, :new, :create, :show, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:sendgrid, :index_with_payed, :edit, :update, :destroy]
  # GET /gt_registrations
  # GET /gt_registrations.json
  def index
    @gt_registrations = GtRegistration.all.where(payed: true)
  end

  def index_with_payed
    @gt_registrations = GtRegistration.where(gt_race: @gt_race).order(:id).to_a
    @grouped_by_gt_category = @gt_registrations.group_by {|r| r.gt_category_id }
    @categories = GtCategory.where(id: @grouped_by_gt_category.keys)
    @junior = GtCategory.find_by(name: "Junior")
    @gt_registrations = GtRegistration.where(gt_race: @gt_race).includes(:gt_category)
    respond_to do |format|
      format.html
      format.csv { send_data @gt_registrations.to_csv }
    end
    # @order_cat = GtPrice.joins(:gt_category).where(gt_category_id: @grouped_by_gt_category.keys ).order(:price)
  end

  def sendgrid
    @gt_registrations = GtRegistration.where(gt_race: @gt_race)
    respond_to do |format|
      format.html
      format.csv { send_data @gt_registrations.to_csv_sendgrid }
    end
  end

  # GET /gt_registrations/1
  # GET /gt_registrations/1.json
  def show
  end

  # GET /gt_registrations/new
  # def new


  #   @gt_registration = @gt_race.gt_registrations.build
  #   @price = GtPrice.where(gt_race: @gt_race, gt_category: @gt_category).where("DATE(until) >= ?", Date.today ).order('until ASC').first.try(:price).to_f
  #   if @price == 0
  #     flash[:alert] = "Omlouvame se, ale stala se chyba pri vypoctu ceny. Tato chyba bude opravena do 24h"
  #     Notifier.error_admin("adamplansky@gmail.com", "GtRaces::GtCategories::GtRegistrationsController#new @price == 0 @gt_race: #{@gt_race.inspect} @gt_category: #{@gt_category.inspect} Date.today: #{Date.today}" ).deliver_now
  #   end

  #   if @gt_race.registration_end && @gt_race.registration_end < DateTime.now
  #     flash[:alert] = "Registrace uzavreny"
  #     flash[:notice] = "Registrace uzavreny"
  #     flash[:error] = "Registrace uzavreny"
  #     @price = 0
  #     return
  #   end
  #   @gt_registration.price = @price
  # end

  # GET /gt_registrations/1/edit
  def edit
    @price = @gt_registration.price
  end

  # POST /gt_registrations
  # POST /gt_registrations.json
  def create

    @gt_registration = GtRegistration.new(gt_registration_params)
    @gt_registration.gt_race = @gt_race
    @gt_registration.gt_category = @gt_category
    respond_to do |format|
      if @gt_registration.save && !(@gt_race.registration_end && @gt_race.registration_end < DateTime.now)
        format.html { redirect_to [@gt_race,@gt_category,@gt_registration], notice: 'Gt registration was successfully created.' }
        format.json { render :show, status: :created, location: @gt_registration }
        Notifier.race_registration(@gt_registration).deliver_now
        if Rails.env.production?
          Notifier.race_registration_direct(@gt_registration, "adamplansky@seznam.cz,hege8400@seznam.cz,jiricimler@centrum.cz").deliver_now
        end
      else
        #format.html { render :new,  :params => { gt_race: @gt_race, gt_category: @gt_category } }
        format.html { render :new }
        format.json { render json: @gt_registration.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /gt_registrations/1
  # PATCH/PUT /gt_registrations/1.json
  def update
    respond_to do |format|
      if @gt_registration.update(gt_registration_params)
        format.html { redirect_to index_with_payed_gt_race_gt_category_gt_registrations_path(@gt_race,0), notice: 'Gt registration was successfully updated.' }
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
      format.html { redirect_to index_with_payed_gt_race_gt_category_gt_registrations_path(@gt_race,0), notice: 'Gt registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gt_registration
    @gt_registration = GtRegistration.find(params[:id])
  end
  def set_gt_race
    @gt_race = GtRace.find(params[:gt_race_id])
  end
  def set_gt_guide_category
    if params[:gt_category_id].to_i > 0
      @gt_category = GtCategory.find(params[:gt_category_id])
    else
      @gt_category = GtCategory.all
    end
  end



  # Never trust parameters from the scary internet, only allow the white list through.
  def gt_registration_params
    params.require(:gt_registration).permit(:firstname, :surname,:gt_race_id, :price, :street, :city, :psc, :phone_number,:code, :birth, :sex, :notes, :email, :team, :payed,:teammate_firstname, :teammate_surname, :teammate_sex,:team_name, :gt_category_id, :teammate_birth)
  end
end
