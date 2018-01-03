class AddMembershipToUser < ActiveRecord::Migration
  def up
    add_column :users, :is_member, :boolean, default: false
  end

  def down
    remove_column :users, :is_member
  end
end
