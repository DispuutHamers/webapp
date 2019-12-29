class AddPictureToBeers < ActiveRecord::Migration[5.0]
def change
    add_column :beers, :picture, :string
  end
end
