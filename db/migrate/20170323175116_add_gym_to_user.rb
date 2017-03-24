class AddGymToUser < ActiveRecord::Migration
  def up
    add_column :users, :gym_id, :integer
  end
  def down
    remove_column :users, :gym_id
  end
end
