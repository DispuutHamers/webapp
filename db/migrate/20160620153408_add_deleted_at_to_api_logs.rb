class AddDeletedAtToApiLogs < ActiveRecord::Migration
  def change
    add_column :api_logs, :deleted_at, :datetime
    add_index :api_logs, :deleted_at
  end
end
