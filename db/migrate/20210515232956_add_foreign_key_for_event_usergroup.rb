class AddForeignKeyForEventUsergroup < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :usergroup_id, :integer
  end
end
