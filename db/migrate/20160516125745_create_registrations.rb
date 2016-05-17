class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.boolean :payed, default: false
      t.datetime :registration_time
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index(:registrations, [:user_id, :event_id], unique: true)

  end
end
