class AddBirthAndAgeGtRegistration < ActiveRecord::Migration
  def change
    add_column :gt_registrations, :age, :integer
    add_column :gt_registrations, :teammate_age, :integer
    add_column :gt_registrations, :teammate_birth, :date
  end
end
