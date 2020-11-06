class DropPushes < ActiveRecord::Migration[6.0]
  def change
    drop_table :pushes
  end
end
