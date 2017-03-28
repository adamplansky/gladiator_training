class CreateGymWars < ActiveRecord::Migration
  def change
    create_table :gym_wars do |t|
      t.text :description

      t.timestamps null: false
    end
  end
end
