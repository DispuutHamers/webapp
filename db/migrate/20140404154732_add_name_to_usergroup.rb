class AddNameToUsergroup < ActiveRecord::Migration
  def change
    add_column :usergroups, :name, :string
  end
end
