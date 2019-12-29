class AddDeletedAtToNicknames < ActiveRecord::Migration[5.0]
def change
    add_column :nicknames, :deleted_at, :datetime
    add_index :nicknames, :deleted_at
  end
end
