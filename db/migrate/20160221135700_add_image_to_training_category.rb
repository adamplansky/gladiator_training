class AddImageToTrainingCategory < ActiveRecord::Migration
  def up
    add_column :training_categories, :image, :string
  end

  def down
    remove_columns :training_categories, :image
  end
end
