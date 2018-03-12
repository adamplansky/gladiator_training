class AddDescriptionToGtCategories < ActiveRecord::Migration
  def change
    add_column :gt_categories, :description, :string
  end
end
