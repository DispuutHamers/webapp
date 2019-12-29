class CreateQuotes < ActiveRecord::Migration[5.0]
def change
    create_table :quotes do |t|
      t.string :text
      t.integer :user_id
      t.integer :reporter

      t.timestamps
    end
    add_index :quotes, [:user_id, :created_at]
  end
end
