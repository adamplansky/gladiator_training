class AddPlaceToEvent < ActiveRecord::Migration
  def up
    add_column :events, :place, :string
    add_column :events, :place_url, :string
  end

  def down
    remove_column :events, :place
    remove_column :events, :place_url
  end
end
