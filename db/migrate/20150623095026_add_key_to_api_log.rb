class AddKeyToApiLog < ActiveRecord::Migration[5.0]
def change
    add_column :api_logs, :key, :string
  end
end
