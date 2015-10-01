class ReservationsUsersController < ApplicationController
  def create
    r = Reservation.find_by_id(params[:id])
    if r.users << current_user
      flash[:success] = "Rezervace provedena."     
      redirect_to r
    else
      flash[:success] = "Rezervace neprovedena."     
      redirect_to reservations_path
    end
  end
  
  def destroy
    r = Reservation.find_by_id(params[:id])
    u = current_user
    if r
      r.users.delete(u)
    end
    
    
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
