class GtRace < ActiveRecord::Base
  has_many :gt_prices
  has_many :gt_registrations
end
