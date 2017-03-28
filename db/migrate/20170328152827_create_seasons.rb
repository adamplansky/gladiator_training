class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.datetime :from_time
      t.datetime :to_time
      t.string :name

      t.timestamps null: false
    end
  end
end
