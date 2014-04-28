class AddUserIdAndDeadlineToEvents < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    add_column :events, :deadline, :datetime
  end
end
