class GtRaces::GtGuideCategoriesController < ApplicationController
  layout 'races'
  before_action :set_gt_race #, only: [:index, :create, :new, :show, :edit, :update, :destroy]
  def index
    @others_category_size = GtRegistration.not_junior_category_size(@gt_race.id)
    @junior_category_size = GtRegistration.junior_category_size(@gt_race.id)
    @junior_capacity = @gt_race.max_junior_capacity
    @others_capacity = @gt_race.max_others_capacity
    @singles = GtCategory.where(single: true)
    @teams = GtCategory.where(single: false)
  end


  private
  def set_gt_race
    @gt_race = GtRace.find(params[:gt_race_id])
  end

end
