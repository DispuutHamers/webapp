class ChangeNewEventMailToDefaultFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :new_event_mail, :boolean, default: false
  end
end
