class RenameColumnsPeriod < ActiveRecord::Migration
  def up
    rename_column :periods, :from, :time_from
    rename_column :periods, :to, :time_to
  end

  def down
    rename_column :periods, :time_from, :from
    rename_column :periods,  :time_to, :to
  end
end
