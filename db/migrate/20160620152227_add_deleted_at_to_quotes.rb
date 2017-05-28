class AddDeletedAtToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :deleted_at, :datetime
    add_index :quotes, :deleted_at
  end
end
