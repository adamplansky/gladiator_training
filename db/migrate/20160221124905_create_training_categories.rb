class CreateTrainingCategories < ActiveRecord::Migration
  def change
    create_table :training_categories do |t|
      t.string :name
      t.float :koef
      t.integer :minimum
      t.text :description
      t.string :units

      t.timestamps null: false
    end
  end
end
