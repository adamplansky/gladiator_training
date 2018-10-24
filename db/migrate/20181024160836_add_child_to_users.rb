class AddChildToUsers < ActiveRecord::Migration
  def up
    add_column :users, :is_member_child_4, :boolean, default: false
    add_column :users, :is_member_child_9, :boolean, default: false
  end

  def down
    remove_column :users, :is_member_child_4
    remove_column :users, :is_member_child_9
  end
end
