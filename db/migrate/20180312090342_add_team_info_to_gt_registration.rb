class AddTeamInfoToGtRegistration < ActiveRecord::Migration
  def change
    add_column :gt_registrations, :teammate_sex, :string
    add_column :gt_registrations, :team_name, :string
    add_reference :gt_registrations, :gt_category, index: true
  end
end
