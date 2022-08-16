class SetNewEventEmailsFalse < ActiveRecord::Migration[6.1]
  def change
    User.all.each { |user| user.update_column(:new_event_mail, false) }
  end
end
