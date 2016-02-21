class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.integer :training_category_id
      t.float :points
      t.text :description
      t.float :distance

      t.timestamps null: false
    end
  end
end
