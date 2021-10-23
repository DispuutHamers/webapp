class AddDeletedAtToBlogitems < ActiveRecord::Migration[6.1]
  def change
    add_column :blogitems, :deleted_at, :datetime
    add_index :blogitems, :deleted_at
  end
end
