class AddDeletedAtToStickers < ActiveRecord::Migration[5.0]
def change
    add_column :stickers, :deleted_at, :datetime
    add_index :stickers, :deleted_at
  end
end
