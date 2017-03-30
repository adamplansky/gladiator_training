class AddFkToUserTeams < ActiveRecord::Migration
  def up
    add_index :user_teams, [:team_id, :user_id], :unique => true
    add_foreign_key :user_teams, :teams
    add_foreign_key :user_teams, :users

  end

  def down
    remove_index :user_teams
    remove_foreign_key :user_teams, :teams
    remove_foreign_key :user_teams, :users

  end
end
