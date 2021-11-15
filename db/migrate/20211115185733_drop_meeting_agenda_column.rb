class DropMeetingAgendaColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :meetings, :agenda
  end
end
