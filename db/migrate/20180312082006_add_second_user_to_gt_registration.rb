class AddSecondUserToGtRegistration < ActiveRecord::Migration
  def change
    add_column :gt_registrations, :teammate_firstname, :string
    add_column :gt_registrations, :teammate_surname, :string
  end
end
