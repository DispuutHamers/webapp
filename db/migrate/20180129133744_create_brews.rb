class CreateBrews < ActiveRecord::Migration[5.2]
  def change
    create_table :brews do |t|
      t.text :description
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
