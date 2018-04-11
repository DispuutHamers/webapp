class DropVotes < ActiveRecord::Migration[5.2]
  def change
    drop_table :votes
  end
end
