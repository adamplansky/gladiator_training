class AddFreeOpenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :is_free_open, :boolean, default: false
  end

  def down
    remove_column :users, :is_free_open
  end
end
