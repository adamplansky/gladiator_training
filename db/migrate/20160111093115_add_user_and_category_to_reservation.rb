class AddUserAndCategoryToReservation < ActiveRecord::Migration
  def up
    add_column :reservations, :category_id, :integer
  end
  def down
    remove_column :reservations, :category_id
  end
end
