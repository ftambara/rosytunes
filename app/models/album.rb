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

  def self.search(query)
    gateway.list_of(mb_adapter, matching: query)
  end

  def self.mb_adapter = MbAlbumAdapter

  private
    def self.gateway = MusicLibraryGateway.new
end
