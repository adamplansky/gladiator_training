class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout 'subapplication', only: [:show]
  before_action :logged_in_user, only: [:show, :update]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @trainings = @user.trainings.page(params[:page])
    @period = Period.where("time_from < ? AND time_to > ?", Time.now, Time.now).first

    h = Training.unscope(:order).
      joins(:user).
      select('users.*, sum_points').
      where(user: @user, period_id: @period).
      group("training_category_id").
      sum(:points)
    @ary = [['a', 'b']]
    h.each { |k, v| @ary << [TrainingCategory.find(k).name, v] }
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to edit_user_path(current_user) if @user != current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to '/signin', notice: 'Uživatel vytvořen.' }
        format.json { render :show, status: :created, location: @user }

      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    #puts "@params[:gym]: #{params[:user][:gym]}"
    #@gym = Gym.find(params[:user][:gym])

    redirect_to edit_user_path(current_user) if @user != current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to challenges_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    User.update_all(is_member: false)
    User.where(id: params.dig(:user_ids, :id)).each do |user|
      user.update_attribute(:is_member, true)
    end
    User.update_all(is_member_child_4: false)
    User.where(id: params.dig(:child_ids_4, :id)).each do |user|
      user.update_attribute(:is_member_child_4, true)
    end
    User.update_all(is_member_child_9: false)
    User.where(id: params.dig(:child_ids_9, :id)).each do |user|
      user.update_attribute(:is_member_child_9, true)
    end

    User.update_all(is_free_open: false)
    User.where(id: params.dig(:free_open, :id)).each do |user|
      user.update_attribute(:is_free_open, true)
    end

    redirect_to :memberships_all_members
    #User.update_all(["is_member=?", True] id: params[:user_ids])
    #User.update_all({:is_member => true}, {:id => params[:user_ids]})

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :surname,
      :password,
      :password_confirmation,
      :gym_id,
      :gender,
      :image,
      :is_member,
      :is_member_child_4,
      :is_member_child_9,
      :is_free_open
    )
  end
end
