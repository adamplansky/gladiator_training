class GtPrice < ActiveRecord::Base
  belongs_to :gt_race
  belongs_to :gt_category
  belongs_to :gt_registration

  def self.grouped_by_id(gt_race_id)
    self.where(gt_race_id: gt_race_id).group_by(&:gt_category_id)
  end
end
