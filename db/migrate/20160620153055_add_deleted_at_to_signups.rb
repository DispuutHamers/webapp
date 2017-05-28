class AddDeletedAtToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :deleted_at, :datetime
    add_index :signups, :deleted_at
  end
end
