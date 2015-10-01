class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :time_from
      t.datetime :time_to
      t.decimal :money
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
