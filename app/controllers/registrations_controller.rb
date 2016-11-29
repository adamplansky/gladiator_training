class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:update]
  def create
    r = Event.find_by_id(params[:id])
    if r.users << current_user
      flash[:success] = "Registrace provedena."
      redirect_to r
    else
      flash[:success] = "Registrace neprovedena."
      redirect_to events_path
    end
  end

  def show
    @registration = Event.find_by(id: params[:id])
  end
  def edit

  end
  def update
    @reg.payed = !@reg.payed
    @reg.save
    format.html { redirect_to @reg.event, notice: 'Registrace zaplacena.' }
  end
  def destroy
    e = Event.find_by_id(params[:id])
    u = User.find_by_id(params[:format]) if current_user.admin?
    u = current_user if u.nil?
    if e
      e.users.delete(u)
    end
    if current_user == u
      redirect_to events_url, notice: 'Registrace zrušena.'
    else
      redirect_to e, notice: 'Registrace zrušena.'
    end
  end

  private
  def set_registration
    @reg = Registration.find(params[:id])
  end
end
