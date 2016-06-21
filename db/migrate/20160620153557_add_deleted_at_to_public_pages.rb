class AddDeletedAtToPublicPages < ActiveRecord::Migration
  def change
    add_column :public_pages, :deleted_at, :datetime
    add_index :public_pages, :deleted_at
  end
end
