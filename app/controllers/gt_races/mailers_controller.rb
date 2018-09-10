class GtRaces::MailersController < ApplicationController
  layout 'races'
  before_action :set_gt_race, only: [:send_unpaid_gt_races_mail]

  def send_unpaid_gt_races_mail
    logger.debug '-------fuck--------'
    logger.debug '-------send_unpaid_gt_races_mail--------'
    registrations = GtRegistration.where(gt_race: @gt_race, payed: false)
    registrations.each do |registration|
      Notifier.race_registration_reminder(registration).deliver_now
    end
    render plain: "maily odeslany"
  end

  def set_gt_race
    @gt_race = GtRace.find(params[:gt_race_id])
  end

end
