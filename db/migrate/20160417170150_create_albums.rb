class CreateAlbums < ActiveRecord::Migration[5.0]
def change
    create_table :albums do |t|
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
