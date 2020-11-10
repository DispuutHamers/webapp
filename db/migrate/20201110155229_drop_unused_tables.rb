class DropUnusedTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :active_storage_attachments
    drop_table :active_storage_blobs
    drop_table :ar_internal_metadata
    drop_table :brew_temps
    drop_table :devices
    drop_table :documentation_pages
    drop_table :documentation_screenshots
    drop_table :motions
    drop_table :nifty_attachments
    drop_table :pictures
    drop_table :statics
  end
end
