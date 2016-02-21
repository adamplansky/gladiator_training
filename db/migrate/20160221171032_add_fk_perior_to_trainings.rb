class AddFkPeriorToTrainings < ActiveRecord::Migration
  def up
    add_column :trainings, :period_id, :integer
    add_foreign_key :trainings, :periods
  end

  def down
    remove_column :trainings, :period_id, :integer
    remove_foreign_key :trainings, :periods
  end

end
