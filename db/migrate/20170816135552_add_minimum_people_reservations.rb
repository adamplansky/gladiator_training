class AddMinimumPeopleReservations < ActiveRecord::Migration
  def up
    add_column :reservations, :min_people, :integer, default: 0
  end
  def down
    remove_column :reservations, :min_people
  end
end
