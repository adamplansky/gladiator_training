class StatisticsController < ApplicationController
  layout 'subapplication'
  before_action :logged_in_user
  def index
    @categories = TrainingCategory.all
    @users = User.all
    @results = {}
    @categories.each do |category|
      tsum = Training.unscope(:order).joins(:user).where(training_category: category.id).group("user_id").order("sum_points DESC").sum(:points).take(5)
      @results[category] = Training.unscope(:order).joins(:user).where(training_category: category.id).group("user_id").order("sum_points DESC").sum(:points).take(5) unless tsum.empty?
    end
    @sum_all_points =  Training.unscope(:order).joins(:user).group("user_id").order("sum_points DESC").sum(:points).take(10)
  end

  def show
    @category = TrainingCategory.find_by_id(params[:id])
    @users = User.all
    if @category
      @result = Training.unscope(:order).joins(:user).where(training_category: @category.id).group("user_id").order("sum_points DESC").sum(:points)
    else
      @result =  Training.unscope(:order).joins(:user).group("user_id").order("sum_points DESC").sum(:points).take(10)
    end
  end
end