class AddCreatedAtToReservationUsers < ActiveRecord::Migration
  def up
    change_table :reservations_users, :id => false do |t|
      t.timestamps
    end
  end
  def down
    remove_column :reservations_users, :created_at
    remove_column :reservations_users, :updated_at
  end
end

