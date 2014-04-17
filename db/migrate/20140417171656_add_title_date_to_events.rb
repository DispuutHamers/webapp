class AddTitleDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :title, :string
    add_column :events, :date, :date
  end
end
