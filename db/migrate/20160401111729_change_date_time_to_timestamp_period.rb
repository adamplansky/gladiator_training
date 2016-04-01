class ChangeDateTimeToTimestampPeriod < ActiveRecord::Migration
  def up
    change_column :periods, :time_from_1, :timestamp
    change_column :periods, :time_to_1, :timestamp
    change_column :periods, :time_from_2, :timestamp
    change_column :periods, :time_to_2, :timestamp
    change_column :periods, :time_from_3, :timestamp
    change_column :periods, :time_to_3, :timestamp
  end

  def down
    change_column :periods, :time_from_1, :datetime
    change_column :periods, :time_to_1, :datetime
    change_column :periods, :time_from_2, :datetime
    change_column :periods, :time_to_2, :datetime
    change_column :periods, :time_from_3, :datetime
    change_column :periods, :time_to_3, :datetime
  end
end
