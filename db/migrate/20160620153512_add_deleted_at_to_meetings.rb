class AddDeletedAtToMeetings < ActiveRecord::Migration[5.0]
def change
    add_column :meetings, :deleted_at, :datetime
    add_index :meetings, :deleted_at
  end
end
