class DropLeftoverTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :pushes
    drop_table :rpush_apps
    drop_table :rpush_feedback
    drop_table :rpush_notifications
  end
end
