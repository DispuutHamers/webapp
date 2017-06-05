class AddPublicBoolToBlogitem < ActiveRecord::Migration[5.0]
  def change
    add_column :blogitems, :public, :bool, default: false
  end
end
