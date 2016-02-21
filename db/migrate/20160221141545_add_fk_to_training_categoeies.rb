class AddFkToTrainingCategoeies < ActiveRecord::Migration
  def up
    add_foreign_key :trainings, :training_categories
  end
  def down
    remove_foreign_key :trainings, :training_categories
  end
end
