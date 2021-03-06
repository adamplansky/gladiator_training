class GtRaces::StartingListController < ApplicationController
  layout 'races'
  include GtRegistrationsHelper
  before_action :set_gt_race, only: [:index]

  def index
    @gt_registrations = @gt_race.gt_registrations.order(:payed, :id)
    @gt_size = @gt_registrations.size
    #@gt_registrations = @gt_race.joins(gt_registrations).order(:id)
  end

  private

  def set_gt_race
    @gt_race = GtRace.find(params[:gt_race_id])
  end
end
