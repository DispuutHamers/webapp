class AddSundayRatioToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sunday_ratio, :float, default: 0
  end
end
