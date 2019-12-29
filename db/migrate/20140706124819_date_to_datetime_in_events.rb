class DateToDatetimeInEvents < ActiveRecord::Migration[5.0]
def change
		change_column :events, :date, :datetime
  end
end
