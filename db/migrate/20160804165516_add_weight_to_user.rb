class AddWeightToUser < ActiveRecord::Migration
  def change
    add_column :users, :weight, :double, default: 0
  end
end
