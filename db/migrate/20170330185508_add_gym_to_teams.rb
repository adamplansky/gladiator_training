class AddGymToTeams < ActiveRecord::Migration
  def up
    add_reference :teams, :gym, index: true, foreign_key: true
  end
  def down
    remove_reference :teams, :gym, index: true, foreign_key: true
  end
end
