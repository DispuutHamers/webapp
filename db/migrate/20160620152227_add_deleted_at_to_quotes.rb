class AddDeletedAtToQuotes < ActiveRecord::Migration[5.0]
def change
    add_column :quotes, :deleted_at, :datetime
    add_index :quotes, :deleted_at
  end
end
