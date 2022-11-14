class Artist < ApplicationRecord
  include CanAccessLibrary

  validates :name, presence: true # BUG, make it appear on tests
  validates :api_id,
    presence: true,
    uniqueness: true

  attr_accessor :name
end
