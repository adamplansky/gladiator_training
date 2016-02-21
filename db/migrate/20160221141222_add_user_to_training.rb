class AddUserToTraining < ActiveRecord::Migration
  def up
    add_column :trainings, :user_id, :integer
    add_foreign_key :trainings, :users
  end
  def down
    remove_column :trainings, :user_id
    remove_foreign_key :training, :users
  end
end
