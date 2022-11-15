class Artist < ApplicationRecord
  include CanAccessLibrary

  validates :api_id,
    presence: true,
    uniqueness: true

  lib_attr_accessor :name, :albums
end
