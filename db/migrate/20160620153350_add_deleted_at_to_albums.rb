class AddDeletedAtToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :deleted_at, :datetime
    add_index :albums, :deleted_at
  end
end
