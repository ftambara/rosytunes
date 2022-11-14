class Song < ApplicationRecord
  validates :name, presence: true
  validates :api_id,
    presence: true,
    uniqueness: true
end
