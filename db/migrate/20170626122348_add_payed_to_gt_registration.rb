class AddPayedToGtRegistration < ActiveRecord::Migration
  def up
    add_column :gt_registrations, :payed, :boolean, default: false
  end

  def down
    remove_column :gt_registrations
  end
end
