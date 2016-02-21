class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.datetime :from
      t.datetime :to
      t.string :name

      t.timestamps null: false
    end
  end
end
