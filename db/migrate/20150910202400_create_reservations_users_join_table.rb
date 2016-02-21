class CreateReservationsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :reservations_users, :id => false do |t|
      t.integer :reservation_id
      t.integer :user_id
    end
  end
end
