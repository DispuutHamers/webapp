class CreateImages < ActiveRecord::Migration[5.0]
def change
    create_table :images do |t|
      t.string :title
      t.string :image_id
      t.string :description
      t.integer :album_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
