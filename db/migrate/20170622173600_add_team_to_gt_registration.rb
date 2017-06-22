class AddTeamToGtRegistration < ActiveRecord::Migration
  def up
    add_column :gt_registrations, :team, :string
  end
  def down
    remove_column :gt_registrations, :team
  end
end
