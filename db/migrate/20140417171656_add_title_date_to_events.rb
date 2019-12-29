class AddTitleDateToEvents < ActiveRecord::Migration[5.0]
def change
    add_column :events, :title, :string
    add_column :events, :date, :date
  end
end
