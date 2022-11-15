module SearchHelper
  def all_entities
    { "Album"  => Album,
      "Artist" => Artist,
      "Song"   => Song }
  end

  def searchable_entities
    { "Albums" => Album, "Artists" => Artist }
  end
end
