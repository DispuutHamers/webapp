class AddDeletedAtToMotions < ActiveRecord::Migration
  def change
    add_column :motions, :deleted_at, :datetime
    add_index :motions, :deleted_at
  end
end
