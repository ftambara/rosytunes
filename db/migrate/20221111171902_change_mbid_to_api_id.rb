class ChangeMbidToApiId < ActiveRecord::Migration[7.0]
  def change
    rename_column :albums, :mbid, :api_id
    change_column :albums, :api_id, :string, limit: 30
    rename_column :artists, :mbid, :api_id
    change_column :artists, :api_id, :string, limit: 30
    rename_column :songs, :mbid, :api_id
    change_column :songs, :api_id, :string, limit: 30
  end
end
