class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update, :destroy]

  def index
    @reservations = Reservation.where("time_from > ?", Time.now )
    @reservations = Reservation.where("time_from > ?", Time.now - 24.hours ) if current_user.admin?
  end
  def show
    @reservation = Reservation.find(params[:id])
    @regular_users =  @reservation.reservation_users.limit(@reservation.capacity)
    @nahradnici = @reservation.reservation_users.offset(@reservation.capacity)
    @nahradnici_include = @nahradnici.include? current_user
  end

  def new
    @reservation = Reservation.new
  end

  def edit

  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_path, notice: 'Rezervace vytvořena.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.users.delete_all
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Rezervace odstraněna.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:time_from, :time_to, :capacity, :place_id, :category_id)
    end
end
