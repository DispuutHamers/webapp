class AddAttendanceToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :attendance, :boolean, default: false
  end
end
