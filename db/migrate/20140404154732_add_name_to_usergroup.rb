class AddNameToUsergroup < ActiveRecord::Migration[5.0]
def change
    add_column :usergroups, :name, :string
  end
end
