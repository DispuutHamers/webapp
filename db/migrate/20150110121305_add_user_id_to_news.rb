class AddUserIdToNews < ActiveRecord::Migration[5.0]
def change
    add_column :news, :user_id, :integer
  end
end
