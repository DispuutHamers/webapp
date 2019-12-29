class CreateApiKeys < ActiveRecord::Migration[5.0]
def change
    create_table :api_keys do |t|
      t.string :key
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
