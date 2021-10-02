class RenameBeerKindColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :beers, :soort, :kind
  end
end
