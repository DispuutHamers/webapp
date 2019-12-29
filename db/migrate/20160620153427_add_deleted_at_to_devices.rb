class AddDeletedAtToDevices < ActiveRecord::Migration[5.0]
def change
    add_column :devices, :deleted_at, :datetime
    add_index :devices, :deleted_at
  end
end
