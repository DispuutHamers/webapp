class AddPancakedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pancaked, :integer, default: 0
  end
end
