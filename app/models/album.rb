class Album < ApplicationRecord
  include CanAccessLibrary

  enum :release_type, { "Album"       => 0,
                        "Single"      => 1,
                        "Compilation" => 2 }
  validates :api_id,
    presence: true,
    uniqueness: true

  lib_attr_accessor :name, :release_type, :release_date, :artists, :songs
end
