class RenameSundayRatioToDrinkRatio < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :sunday_ratio, :drink_ratio
  end
end
