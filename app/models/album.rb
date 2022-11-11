class Album < ApplicationRecord
  enum :release_type, { "Album"       => 0,
                        "EP"          => 1,
                        "Compilation" => 2,
                        "Live"        => 3 }
  validates :mbid,
    presence: true,
    uniqueness: true
  validates :name, presence: true

  has_and_belongs_to_many :artists
  has_and_belongs_to_many :songs

  class << self
    include CanAccessLibrary

    def mb_adapter = MbAlbumAdapter
  end
end
