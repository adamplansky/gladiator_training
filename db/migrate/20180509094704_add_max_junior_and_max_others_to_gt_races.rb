class AddMaxJuniorAndMaxOthersToGtRaces < ActiveRecord::Migration
  def change
    add_column :gt_races, :max_junior_capacity, :integer
    add_column :gt_races, :max_others_capacity, :integer
  end
end
