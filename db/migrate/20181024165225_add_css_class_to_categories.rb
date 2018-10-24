class AddCssClassToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :css_class, :string
  end

  def down
    remove_column :categories, :css_class
  end
end
