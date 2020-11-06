class DropRpushApps < ActiveRecord::Migration[6.0]
  def change
    drop_table :rpush_apps
  end
end
