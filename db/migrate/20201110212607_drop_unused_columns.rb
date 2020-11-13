class DropUnusedColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :approved
    remove_column :news, :image
  end
end
