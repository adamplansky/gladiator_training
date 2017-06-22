class CreateGtRaces < ActiveRecord::Migration
  def change
    create_table :gt_races do |t|
      t.string :name
      t.date :published
      t.text :text
      t.text :place
      t.text :url

      t.timestamps null: false
    end
  end
end
