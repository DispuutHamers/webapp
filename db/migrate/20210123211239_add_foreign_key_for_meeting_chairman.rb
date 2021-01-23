class AddForeignKeyForMeetingChairman < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :chairman_id, :integer
  end
end
