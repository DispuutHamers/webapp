class AddDeletedAtToPublicPushes < ActiveRecord::Migration
  def change
    add_column :pushes, :deleted_at, :datetime
    add_index :pushes, :deleted_at
  end
end
