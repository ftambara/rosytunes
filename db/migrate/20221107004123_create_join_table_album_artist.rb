class CreateJoinTableAlbumArtist < ActiveRecord::Migration[7.0]
  def change
    create_join_table :albums, :artists do |t|
      t.index [:album_id, :artist_id], unique: true
      # t.index [:artist_id, :album_id]
    end
  end
end
