class AllowReleaseDateNullOnAlbums < ActiveRecord::Migration[7.0]
  def change
    change_column_null :albums, :release_date, true
  end
end
