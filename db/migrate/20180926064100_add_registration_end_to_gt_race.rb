class AddRegistrationEndToGtRace < ActiveRecord::Migration
  def up
    add_column :gt_races, :registration_end, :datetime
  end

  def down
    remove_column :gt_races, :registration_end
  end
end
