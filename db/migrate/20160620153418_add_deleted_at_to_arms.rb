class AddDeletedAtToArms < ActiveRecord::Migration
  def change
    add_column :arms, :deleted_at, :datetime
    add_index :arms, :deleted_at
  end
end
