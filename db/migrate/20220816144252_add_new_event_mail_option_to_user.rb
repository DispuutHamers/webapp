class AddNewEventMailOptionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :new_event_mail, :boolean, default: true
  end
end
