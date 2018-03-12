class CreateGtCategories < ActiveRecord::Migration
  def change
    create_table :gt_categories do |t|
      t.string :name
      t.boolean :single

      t.timestamps null: false
    end
  end
end
