class AddKeyToApiLog < ActiveRecord::Migration
  def change
    add_column :api_logs, :key, :string
  end
end
