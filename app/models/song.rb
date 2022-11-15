class Song < ApplicationRecord
  validates :api_id,
    presence: true,
    uniqueness: true

  attr_accessor :name, :length_in_s
end
