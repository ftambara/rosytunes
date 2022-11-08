class Song < ApplicationRecord
  validates :name, presence: true
  validates :mbid,
    presence: true,
    uniqueness: true

  has_and_belongs_to_many :albums
  has_and_belongs_to_many :artists
end
