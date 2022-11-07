module SearchHelper
  def all_entities
    { "Albums"  => Album,
      "Artists" => Artist,
      "Songs"   => Song }
  end
end
