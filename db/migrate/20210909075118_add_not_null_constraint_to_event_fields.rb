class AddNotNullConstraintToEventFields < ActiveRecord::Migration[6.1]
  def change

    Event.where(title: [nil, '']).update_all(title: "A MIGRATION ERROR OCCURRED. LET ONE OF THE DEVS KNOW!")
    Event.where(date: [nil, '']).update_all(title: "A MIGRATION ERROR OCCURRED. LET ONE OF THE DEVS KNOW!")

    change_column_null :events, :title, false
    change_column_null :events, :date, false
  end
end
