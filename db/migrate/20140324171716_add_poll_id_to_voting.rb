class AddPollIdToVoting < ActiveRecord::Migration
  def change
        add_column :votes, :poll_id, :integer
  end
end
