class DropRpushNotifications < ActiveRecord::Migration[6.0]
  def change
    drop_table :rpush_notifications
  end
end
