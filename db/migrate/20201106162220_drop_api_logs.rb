class DropApiLogs < ActiveRecord::Migration[6.0]
  def change
    drop_table :api_logs
  end
end
