class AddMonthsToPeriods < ActiveRecord::Migration
  def up
    add_column :periods, :time_from_1, :datetime
    add_column :periods, :time_to_1, :datetime
    add_column :periods, :time_from_2, :datetime
    add_column :periods, :time_to_2, :datetime
    add_column :periods, :time_from_3, :datetime
    add_column :periods, :time_to_3, :datetime
  end

  def down
    remove_column :periods, :time_from_1
    remove_column :periods, :time_to_1
    remove_column :periods, :time_from_2
    remove_column :periods, :time_to_2
    remove_column :periods, :time_from_3
    remove_column :periods, :time_to_3
  end
end
