class DropActiveStorageTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :active_storage_attachments
    drop_table :active_storage_blobs
  end
end
