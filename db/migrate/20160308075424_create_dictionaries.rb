class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.string :en_name
      t.string :cz_name
      t.string :abr

      t.timestamps null: false
    end
  end
end
