class AddStatusToUserTeams < ActiveRecord::Migration
  def up
    add_column :user_teams, :status, :integer
  end
  def down
    remove_column :user_teams, :status
  end
end
