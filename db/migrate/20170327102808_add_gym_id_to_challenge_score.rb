class AddGymIdToChallengeScore < ActiveRecord::Migration
  def change
    add_reference :challenge_scores, :gym, index: true, foreign_key: true
  end
end
