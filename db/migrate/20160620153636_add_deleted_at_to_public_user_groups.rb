class AddDeletedAtToPublicUserGroups < ActiveRecord::Migration
  def change
    add_column :usergroups, :deleted_at, :datetime
    add_index :usergroups, :deleted_at
  end
end
