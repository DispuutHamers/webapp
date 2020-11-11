class AddMeetingAttendeesAssociation < ActiveRecord::Migration[6.0]
  def change
    create_table :meeting_attendees, id: false do |t|
      t.belongs_to :meeting
      t.belongs_to :user
    end
  end
end
