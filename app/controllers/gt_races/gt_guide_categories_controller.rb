class GtRaces::GtGuideCategoriesController < ApplicationController
  layout 'races'
  before_action :set_gt_race #, only: [:index, :create, :new, :show, :edit, :update, :destroy]
  def index
    @singles = GtCategory.where(single: true)
    @teams = GtCategory.where(single: false)
  end


  private
  def set_gt_race
    @gt_race = GtRace.find(params[:gt_race_id])
  end

end
