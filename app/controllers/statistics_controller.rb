class StatisticsController < ApplicationController
  layout 'subapplication'
  def index
    @categories = TrainingCategory.all
    @users = User.all
    @results = {}
    @categories.each do |category|
      @results[category] = Training.unscope(:order).joins(:user).where(training_category: category.id).group("user_id").order("sum_points DESC").sum(:points).take(5)
    end
    @sum_all_points =  Training.unscope(:order).joins(:user).group("user_id").order("sum_points DESC").sum(:points).take(10)
  end
end