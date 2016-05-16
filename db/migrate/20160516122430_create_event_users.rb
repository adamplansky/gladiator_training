class CreateEventUsers < ActiveRecord::Migration
  def change
    create_table :event_users do |t|
      t.boolean :payed
      t.datetime :registration_time
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
