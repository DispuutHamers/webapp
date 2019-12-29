class CreateMeetings < ActiveRecord::Migration[5.0]
def change
    create_table :meetings do |t|
      t.text :agenda
      t.text :notes

      t.timestamps
    end
  end
end
