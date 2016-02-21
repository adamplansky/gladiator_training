class AddPointsToTrainingCategory < ActiveRecord::Migration
  def up
    add_column :training_categories, :points, :float
  end
  def down
    remove_column :training_categories, :points
  end

end
