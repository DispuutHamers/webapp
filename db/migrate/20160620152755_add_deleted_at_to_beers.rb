class AddDeletedAtToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :deleted_at, :datetime
    add_index :beers, :deleted_at
  end
end
