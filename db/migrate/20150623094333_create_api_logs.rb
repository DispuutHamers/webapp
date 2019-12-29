class CreateApiLogs < ActiveRecord::Migration[5.0]
def change
    create_table :api_logs do |t|
      t.string :ip_addr
      t.string :resource_call
      t.integer :user_id

      t.timestamps
    end
  end
end
