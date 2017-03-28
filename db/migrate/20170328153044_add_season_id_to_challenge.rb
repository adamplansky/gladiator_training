class AddSeasonIdToChallenge < ActiveRecord::Migration
  def change
    add_reference :challenges, :season, index: true, foreign_key: true
  end
end
