class DropBeerPictureColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :beers, :picture
  end
end
