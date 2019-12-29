class CreateNicknames < ActiveRecord::Migration[5.0]
def change
    create_table :nicknames do |t|
      t.references :user, index: true, foreign_key: true
      t.string :nickname
      t.string :description

      t.timestamps null: false
    end
  end
end
