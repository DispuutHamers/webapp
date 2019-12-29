class AddWeightToUser < ActiveRecord::Migration[5.0]
def change
    add_column :users, :weight, :double, default: 0
  end
end
