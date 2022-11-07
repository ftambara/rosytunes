class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.uuid :mbid, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :artists, :mbid, unique: true
  end
end
