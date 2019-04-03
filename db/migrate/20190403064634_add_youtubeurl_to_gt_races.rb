class AddYoutubeurlToGtRaces < ActiveRecord::Migration
  def change
    add_column :gt_races, :youtube_url, :string
  end

  
end
