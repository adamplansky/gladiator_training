class CreateGtRegistrations < ActiveRecord::Migration
  def change
    create_table :gt_registrations do |t|
      t.string :firstname
      t.string :surname
      t.references :gt_race, index: true, foreign_key: true
      t.decimal :price
      t.string :street
      t.string :city
      t.integer :psc
      t.integer :phone_number
      t.integer :code
      t.date :birth
      t.string :sex
      t.text :notes

      t.timestamps null: false
    end
  end
end
