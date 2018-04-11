class CreateBrewTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :brew_temps do |t|
      t.references :brew, foreign_key: true
      t.float :temperature

      t.timestamps
    end
  end
end
