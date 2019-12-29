class AddAnonymousToUsers < ActiveRecord::Migration[5.0]
def change
    add_column :users, :anonymous, :boolean
  end
end
