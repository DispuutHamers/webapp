class DropNicknamesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :nicknames
  end
end
