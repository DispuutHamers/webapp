class AddDeletedAtToPublicPushes < ActiveRecord::Migration[5.0]
def change
    add_column :pushes, :deleted_at, :datetime
    add_index :pushes, :deleted_at
  end
end
