class AddOnderwerpAndUserIdToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :onderwerp, :string
    add_column :meetings, :user_id, :integer
    add_column :meetings, :date, :datetime
  end
end
