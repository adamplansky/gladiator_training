class AddIndexToReservationUsers < ActiveRecord::Migration
  def up
    add_index :reservations_users, [:reservation_id, :user_id], :unique => true
    add_foreign_key :reservations_users, :reservations
    add_foreign_key :reservations_users, :users
  end
  
  def down
    remove_index :reservations_users
    remove_foreign_key :reservations_users, :reservations
    remove_foreign_key :reservations_users, :users
  end
end
