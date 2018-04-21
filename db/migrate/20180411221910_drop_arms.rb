class DropArms < ActiveRecord::Migration[5.2]
  def change
    drop_table :arms
  end
end
