class DropStatics < ActiveRecord::Migration[5.2]
  def change
    drop_table :Statics
  end
end
