class AddAttendeesAssociation < ActiveRecord::Migration[6.0]
  def change
    create_table :attendees do |t|
      t.references :meeting, null: false
      t.references :user, null: false
    end
  end
end
