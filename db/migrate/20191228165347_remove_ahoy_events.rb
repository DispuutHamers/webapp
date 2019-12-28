class RemoveAhoyEvents < ActiveRecord::Migration[5.2]
  def change
    drop_table :ahoy_events
  end
end
