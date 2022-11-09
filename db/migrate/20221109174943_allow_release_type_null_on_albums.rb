class AllowReleaseTypeNullOnAlbums < ActiveRecord::Migration[7.0]
  def change
    change_column_null :albums, :release_type, true
  end
end
