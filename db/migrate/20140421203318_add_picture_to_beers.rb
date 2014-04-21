class AddPictureToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :picture, :string
  end
end
