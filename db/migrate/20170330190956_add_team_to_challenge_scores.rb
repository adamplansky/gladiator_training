class AddTeamToChallengeScores < ActiveRecord::Migration
  def up
    add_reference :challenge_scores, :team, index: true, foreign_key: true
  end
  def down
    remove_reference :challenge_scores, :team, index: true, foreign_key: true
  end
end
