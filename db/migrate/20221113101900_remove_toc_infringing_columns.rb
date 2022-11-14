class RemoveTocInfringingColumns < ActiveRecord::Migration[7.0]
  def change
    remove_columns(:albums, :name, :release_type, :release_date)
    remove_columns(:artists, :name)
    remove_columns(:songs, :name, :length_in_s)
  end
end
