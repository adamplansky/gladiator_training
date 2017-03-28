class AddDescriptionAndWebToGym < ActiveRecord::Migration
  def up
    add_column :gyms, :description, :text
    add_column :gyms, :web, :text
  end

  def down
    remove_column :gyms, :description
    remove_column :gyms, :web
  end
end
