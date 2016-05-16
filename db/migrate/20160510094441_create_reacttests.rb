class CreateReacttests < ActiveRecord::Migration
  def change
    create_table :reacttests do |t|

      t.timestamps null: false
    end
  end
end
