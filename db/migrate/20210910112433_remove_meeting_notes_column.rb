class RemoveMeetingNotesColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :meetings, :notes
  end
end
