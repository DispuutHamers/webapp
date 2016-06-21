class AddDeletedAtToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :deleted_at, :datetime
    add_index :meetings, :deleted_at
  end
end
