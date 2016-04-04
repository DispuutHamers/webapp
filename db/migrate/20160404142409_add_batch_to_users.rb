class AddBatchToUsers < ActiveRecord::Migration
  def change
    add_column :users, :batch, :integer
  end
end
