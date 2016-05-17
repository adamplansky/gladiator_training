class AddUrlContactToEvent < ActiveRecord::Migration
  def up
    add_column :events, :contact_url, :string
  end
  def down
    remove_column :events, :contact_url
  end
end
