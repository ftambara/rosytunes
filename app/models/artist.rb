class Artist < ApplicationRecord
  validates :name, presence: true
  validates :mbid,
    presence: true,
    uniqueness: true

  has_and_belongs_to_many :albums

  class << self
    include CanAccessLibrary

    def mb_adapter = MbArtistAdapter
  end
end
