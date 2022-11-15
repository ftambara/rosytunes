class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.uuid :mbid, null: false
      t.string :name, null: false
      t.integer :length_in_s, minimum: 0

      t.timestamps
    end
    add_index :songs, :mbid, unique: true
  end
end
