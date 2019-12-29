class AddDeletedAtToPublicPages < ActiveRecord::Migration[5.0]
def change
    add_column :public_pages, :deleted_at, :datetime
    add_index :public_pages, :deleted_at
  end
end
