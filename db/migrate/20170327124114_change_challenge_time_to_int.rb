class ChangeChallengeTimeToInt < ActiveRecord::Migration
  def change
    remove_column :challenge_scores, :challenge_time
    add_column :challenge_scores, :challenge_time, :integer
  end

end
