class AddFromToToChallenges < ActiveRecord::Migration
  def up
    add_column :challenges, :from_time, :datetime
    add_column :challenges, :to_time, :datetime
  end
  def down
    remove_column :challenges, :from_time
    remove_column :challenges, :to_time
  end
end
