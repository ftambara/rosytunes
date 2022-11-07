class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.uuid :mbid, null: false
      t.string :name, null: false
      t.integer :release_type, null: false
      t.date :release_date, null: false

      t.timestamps
    end
    add_index :albums, :mbid, unique: true
  end
end
