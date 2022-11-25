module ArtistBookmarksHelper
  def find_artist_bookmark(user:, artist:)
    ArtistBookmark.find_by(user:, artist:) if user && artist
  end
end
