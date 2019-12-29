class CreateDevices < ActiveRecord::Migration[5.0]
def change
    create_table :devices do |t|
      t.integer :user_id
      t.string :device_key

      t.timestamps
    end
  end
end
