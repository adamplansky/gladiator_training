class StatisticsController < ApplicationController
  layout 'subapplication'
  before_action :logged_in_user
  def index
    if params[:period_id] == nil
      @period = Period.where("time_from < ? AND time_to > ?", Time.now, Time.now).first
    else
      @period = Period.find_by_id(params[:period_id])
    end
    @categories = TrainingCategory.all

    @users = User.all
    @results = {}
    @categories.each do |category|
      tsum = Training.unscope(:order).joins(:user).where(training_category: category.id, period_id: @period).group("user_id").order("sum_points DESC").sum(:points).take(5)
      @results[category] = Training.unscope(:order).joins(:user).where(training_category: category.id, period_id: @period).group("user_id").order("sum_points DESC").sum(:points).take(5) unless tsum.empty?
    end
    @sum_all_points =  Training.unscope(:order).joins(:user).where(period_id: @period).group("user_id").order("sum_points DESC").sum(:points).take(10)

  end

  def show
    @category = TrainingCategory.find_by_id(params[:id])
    if params[:period_id] == nil
      @period = Period.where("time_from < ? AND time_to > ?", Time.now, Time.now).first
    else
      @period = Period.find_by_id(params[:period_id])
    end
    @users = User.all
    if @category
      @result = Pgdb.get_statistics(@category.id,@period.id)
    else
      @result = Pgdb.get_all_statistics(@period.id)
    end
  end

  def show_season_category
    @category = TrainingCategory.find_by_id(params[:id])
    @period = params[:period_id]
    @users = User.all
    if @category
      @result = Pgdb.get_statistics(@category.id,@period.id)
    else
      @result = Pgdb.get_all_statistics(@period.id)
    end
  end
end
