class AddChallengeCategoryToChallenge < ActiveRecord::Migration
  def change
    add_reference :challenges, :challenge_category, index: true, foreign_key: true
  end
end
