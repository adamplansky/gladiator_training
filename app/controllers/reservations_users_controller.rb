class ReservationsUsersController < ApplicationController
  def create
    r = Reservation.find_by_id(params[:id])
    if r.users << current_user
      flash[:success] = "Rezervace provedena."
      # redirect_to r
      redirect_to reservations_path
    else
      flash[:success] = "Rezervace neprovedena."
      redirect_to reservations_path
    end
  end

  def destroy
    r = Reservation.find_by_id(params[:id])
    u = User.find_by_id(params[:format]) if current_user.admin?
    if !current_user.admin? && r.time_from - 40.minutes < Time.now
      flash[:success] = "Odhlášení zamítnuto."
      redirect_to reservations_path
      return
    end
    u = current_user if u.nil?

    if r
      r.users.delete(u)
    end


    redirect_to reservations_url, notice: 'Rezervace zrušena.'
  end


end
