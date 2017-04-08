class UserGymWarsController < ApplicationController
  layout 'gymwars'
  before_action :set_user
  before_action :logged_in_admin, only: [:edit, :update]
  def index

  end
  def edit

  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to gyms_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def set_user
    @user = User.find(params[:user_id])
  end
  def user_params
    params.require(:user).permit( :gym_id)
  end
end
