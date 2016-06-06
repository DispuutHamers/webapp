class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.string :lat
      t.string :lon
      t.text :notes
      t.text :picture
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
