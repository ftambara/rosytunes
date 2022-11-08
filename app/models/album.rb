class Album < ApplicationRecord
  enum :release_type, { "Album"       => 0,
                        "EP"          => 1,
                        "Compilation" => 2,
                        "Live"        => 3 }
  validates :mbid,
    presence: true,
    uniqueness: true
  validates :name, presence: true
  validates :release_type, presence: true

  has_and_belongs_to_many :artists

  def self.search(query)
    MusicLibraryGateway.list_of(mb_adapter, matching: query)
  end

  def self.mb_adapter = MbAlbumAdapter

  def blanks_for_search
    %i[ mbid name release_date artists ]
  end
end
