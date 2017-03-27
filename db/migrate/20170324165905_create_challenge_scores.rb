class CreateChallengeScores < ActiveRecord::Migration
  def change
    create_table :challenge_scores do |t|
      t.string :url
      t.time :challenge_time
      t.references :user, index: true, foreign_key: true
      t.references :challenge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
