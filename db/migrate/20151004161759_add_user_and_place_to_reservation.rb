class AddUserAndPlaceToReservation < ActiveRecord::Migration
  def up
    add_column :reservations, :place_id, :integer
    add_column :reservations, :user_id, :integer
  end
  def down
    remove_column :reservations, :place_id
    remove_column :reservations, :user_id
  end
end
