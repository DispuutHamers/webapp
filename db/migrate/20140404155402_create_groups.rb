class CreateGroups < ActiveRecord::Migration[5.0]
def change
    create_table :groups do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
    add_index :groups, :user_id
    add_index :groups, :group_id
    add_index :groups, [:user_id, :group_id], unique: true

  end
end
