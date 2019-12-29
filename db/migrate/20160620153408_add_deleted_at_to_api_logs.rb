class AddDeletedAtToApiLogs < ActiveRecord::Migration[5.0]
def change
    add_column :api_logs, :deleted_at, :datetime
    add_index :api_logs, :deleted_at
  end
end
