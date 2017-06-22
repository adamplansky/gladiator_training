class AddEmailToGtRegistration < ActiveRecord::Migration
  def up
    add_column :gt_registrations, :email, :string
  end
  def down
    remove_column :gt_registrations, :email
  end
end
