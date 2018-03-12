class AddCategoryIdToGtPrice < ActiveRecord::Migration
  def change
    add_reference :gt_prices, :gt_category, index: true
  end
end
