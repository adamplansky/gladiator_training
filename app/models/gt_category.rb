class GtCategory < ActiveRecord::Base
  has_many :gt_categories
  has_one :gt_price
end
