class RecreateUserTeamsMigration < ActiveRecord::Migration
  def change
    drop_table :user_teams
    create_table :user_teams, primary_key: [:user_id, :team_id] do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.integer :status
      t.timestamps
    end
  end
end
