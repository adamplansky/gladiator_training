class CreatePgdbs < ActiveRecord::Migration
  def change
    create_table :pgdbs do |t|

      t.timestamps null: false
    end
  end
end
