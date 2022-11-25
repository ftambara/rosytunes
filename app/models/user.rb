class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :artist_bookmarks
  has_many :artists, through: :artist_bookmarks

  def bookmarked_artist?(artist)
    !artists.where(id: artist.id).empty?
  end
end
