class CreateGtPrices < ActiveRecord::Migration
  def change
    create_table :gt_prices do |t|
      t.date :until
      t.references :gt_race, index: true, foreign_key: true
      t.decimal :price

      t.timestamps null: false
    end
  end
end
