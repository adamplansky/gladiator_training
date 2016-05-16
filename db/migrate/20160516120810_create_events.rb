class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :event_date
      t.datetime :registration_end
      t.string :url
      t.string :image
      t.text :description
      t.decimal :min_money
      t.text :contact

      t.timestamps null: false
    end
  end
end
